// C:\Users\USER\smileatlas_app\lib\src\routes\app_routes.dart

import 'package:flutter/material.dart';

// Make sure this import path matches your actual project's structure:
import 'package:smileatlas_app/src/models/user.dart';

// Screens from your project (adjust import paths if necessary):
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/upload_image_screen.dart';
import '../screens/history_screen.dart';
import '../screens/edit_family_screen.dart';
import '../screens/add_edit_member_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String uploadImage = '/uploadImage';
  static const String history = '/history';
  static const String editFamily = '/editFamily';
  static const String addEditMember = '/addEditMember';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> routes = {
    onboarding: (context) => OnboardingScreen(),
    login: (context) => LoginScreen(),
    home: (context) => HomeScreen(),
    history: (context) => HistoryScreen(),
    editFamily: (context) => const EditFamilyScreen(),

    // UploadImageScreen takes a String memberId
    uploadImage: (context) {
      final args = ModalRoute.of(context)!.settings.arguments;
      final memberId = (args is String) ? args : 'unknown';
      return UploadImageScreen(memberId: memberId);
    },

    // ProfileScreen optionally takes a UserModel? argument
    profile: (context) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is UserModel) {
        return ProfileScreen(member: args);
      }
      return const ProfileScreen(member: null);
    },

    // Add or edit a member (AddEditMemberScreen)
    addEditMember: (context) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is UserModel) {
        // Editing existing member
        return AddEditMemberScreen(member: args);
      }
      // Otherwise, adding a new member
      return const AddEditMemberScreen();
    },
  };
}
