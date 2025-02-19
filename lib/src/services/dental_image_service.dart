import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import '../models/dental_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DentalImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  Future<DentalImage> uploadImage({
    required File imageFile,
    required String memberId,
    required DentalImageType type,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // Generate unique ID for the image
      final String imageId = _uuid.v4();
      final String extension = path.extension(imageFile.path);
      final String fileName = '$imageId$extension';
      
      // Create storage reference
      final storageRef = _storage.ref().child('dental_images/$memberId/$fileName');
      
      // Upload the file
      await storageRef.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'memberId': memberId,
            'type': type.value,
            'uploadDate': DateTime.now().toIso8601String(),
          },
        ),
      );

      // Get download URL
      final String downloadUrl = await storageRef.getDownloadURL();

      // Create DentalImage object
      final dentalImage = DentalImage(
        id: imageId,
        url: downloadUrl,
        type: type,
        captureDate: DateTime.now(),
        memberId: memberId,
        metadata: metadata,
        localPath: imageFile.path,
        isProcessed: false,
      );

      // Save to Firestore
      await _firestore
          .collection('dental_images')
          .doc(imageId)
          .set(dentalImage.toJson());

      return dentalImage;
    } catch (e) {
      throw Exception('Failed to upload dental image: $e');
    }
  }

  Future<List<DentalImage>> getMemberImages(String memberId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('dental_images')
          .where('memberId', isEqualTo: memberId)
          .orderBy('captureDate', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => DentalImage.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch member images: $e');
    }
  }

  Future<void> deleteImage(DentalImage image) async {
    try {
      // Delete from Storage
      final storageRef = _storage.refFromURL(image.url);
      await storageRef.delete();

      // Delete from Firestore
      await _firestore.collection('dental_images').doc(image.id).delete();

      // Delete local file if it exists
      if (image.localPath != null) {
        final localFile = File(image.localPath!);
        if (await localFile.exists()) {
          await localFile.delete();
        }
      }
    } catch (e) {
      throw Exception('Failed to delete dental image: $e');
    }
  }

  Future<void> markImageAsProcessed(String imageId, String analysisId) async {
    try {
      await _firestore.collection('dental_images').doc(imageId).update({
        'isProcessed': true,
        'analysisId': analysisId,
      });
    } catch (e) {
      throw Exception('Failed to update image processing status: $e');
    }
  }

  Future<List<DentalImage>> getUnprocessedImages() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('dental_images')
          .where('isProcessed', isEqualTo: false)
          .get();

      return snapshot.docs
          .map((doc) => DentalImage.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch unprocessed images: $e');
    }
  }
}