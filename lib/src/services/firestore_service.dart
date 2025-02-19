import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create or update a user
  Future<void> setUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toJson(), SetOptions(merge: true));
  }

  // Retrieve a user by ID
  Future<UserModel?> getUser(String userId) async {
    DocumentSnapshot doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Delete a user
  Future<void> deleteUser(String userId) async {
    await _db.collection('users').doc(userId).delete();
  }
}
