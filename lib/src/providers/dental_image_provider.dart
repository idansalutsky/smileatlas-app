import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/dental_image.dart';
import '../services/dental_image_service.dart';

class DentalImageProvider extends ChangeNotifier {
  final DentalImageService _imageService = DentalImageService();
  
  final Map<String, List<DentalImage>> _memberImages = {};
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<DentalImage> getMemberImages(String memberId) {
    return _memberImages[memberId] ?? [];
  }

  Future<void> loadMemberImages(String memberId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final images = await _imageService.getMemberImages(memberId);
      _memberImages[memberId] = images;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<DentalImage?> uploadImage({
    required File imageFile,
    required String memberId,
    required DentalImageType type,
    Map<String, dynamic>? metadata,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final image = await _imageService.uploadImage(
        imageFile: imageFile,
        memberId: memberId,
        type: type,
        metadata: metadata,
      );

      // Update local state
      if (_memberImages.containsKey(memberId)) {
        _memberImages[memberId]!.insert(0, image);
      } else {
        _memberImages[memberId] = [image];
      }

      return image;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteImage(DentalImage image) async {
    _error = null;
    try {
      await _imageService.deleteImage(image);
      
      // Update local state
      if (_memberImages.containsKey(image.memberId)) {
        _memberImages[image.memberId]!.removeWhere((img) => img.id == image.id);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> markImageAsProcessed(String imageId, String analysisId) async {
    _error = null;
    try {
      await _imageService.markImageAsProcessed(imageId, analysisId);
      
      // Update local state
      for (var images in _memberImages.values) {
        for (var i = 0; i < images.length; i++) {
          if (images[i].id == imageId) {
            images[i] = images[i].copyWith(
              isProcessed: true,
              analysisId: analysisId,
            );
            break;
          }
        }
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<List<DentalImage>> getUnprocessedImages() async {
    _error = null;
    try {
      return await _imageService.getUnprocessedImages();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearCache() {
    _memberImages.clear();
    notifyListeners();
  }
}