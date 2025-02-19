import 'package:flutter/material.dart';
import '../models/user.dart';

class FamilyProvider extends ChangeNotifier {
  // Family Name
  String _familyName = 'Our Family';
  String get familyName => _familyName;

  // Existing list of family members
  List<UserModel> _familyMembers = [];
  List<UserModel> get familyMembers => _familyMembers;

  void setFamilyName(String newName) {
    _familyName = newName;
    notifyListeners();
  }

  void addMember(UserModel member) {
    _familyMembers.add(member);
    notifyListeners();
  }

  void removeMember(String memberId) {
    _familyMembers.removeWhere((member) => member.id == memberId);
    notifyListeners();
  }

  void updateMember(UserModel updatedMember) {
    int index = _familyMembers.indexWhere((m) => m.id == updatedMember.id);
    if (index != -1) {
      _familyMembers[index] = updatedMember;
      notifyListeners();
    }
  }
}
