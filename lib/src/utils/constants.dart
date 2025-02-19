import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1E88E5);    // Deep Blue
  static const Color accent = Color(0xFFFF6F61);     // Vibrant Coral
  static const Color background = Color(0xFFF5F5F5); // Light Gray
  
  // Status colors
  static const Color error = Color(0xFFE53935);      // Error Red
  static const Color success = Color(0xFF43A047);    // Success Green
  static const Color warning = Color(0xFFFFA726);    // Warning Orange
  static const Color info = Color(0xFF2196F3);       // Info Blue
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  
  // UI colors
  static const Color divider = Color(0xFFBDBDBD);
  static const Color cardBackground = Colors.white;
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color overlay = Color(0x80000000);
  
  // Dental specific colors
  static const Color healthyTooth = Color(0xFF81C784);
  static const Color concernTooth = Color(0xFFFFB74D);
  static const Color criticalTooth = Color(0xFFE57373);
  static const Color untrackedTooth = Color(0xFFE0E0E0);
}

class AppTypography {
  static const String _fontFamily = 'Roboto';

  static const TextStyle display = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
  );

  static const TextStyle header = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
  );
  
  static const TextStyle subheader = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
  );
  
  static const TextStyle body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static const TextStyle bodyBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );
  
  static const TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );
  
  static const TextStyle overline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
  );
}

class AppSpacing {
  static const double xxxsmall = 2.0;
  static const double xxsmall = 4.0;
  static const double xsmall = 8.0;
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xlarge = 32.0;
  static const double xxlarge = 48.0;
  static const double xxxlarge = 64.0;
  
  // Specific spacing for dental map
  static const double toothSpacing = 6.0;
  static const double jawSpacing = 20.0;
}

class AppDurations {
  static const Duration fastest = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 700);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration splashScreen = Duration(seconds: 2);
}

class AppBorderRadius {
  static const double small = 4.0;
  static const double medium = 8.0;
  static const double large = 12.0;
  static const double xlarge = 16.0;
  
  static BorderRadius get smallAll => BorderRadius.circular(small);
  static BorderRadius get mediumAll => BorderRadius.circular(medium);
  static BorderRadius get largeAll => BorderRadius.circular(large);
  static BorderRadius get xlargeAll => BorderRadius.circular(xlarge);
  
  static const BorderRadius smallTop = BorderRadius.vertical(
    top: Radius.circular(small),
  );
  
  static const BorderRadius mediumTop = BorderRadius.vertical(
    top: Radius.circular(medium),
  );
}

class AppConfig {
  // API Endpoints
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Cache Configuration
  static const Duration imageCacheDuration = Duration(days: 7);
  static const int maxCachedImages = 100;
  
  // Analytics
  static const Duration sessionTimeout = Duration(minutes: 30);
  static const bool analyticsEnabled = true;
  
  // Feature Flags
  static const bool enablePushNotifications = true;
  static const bool enableImageSharing = true;
  static const bool enableCloudBackup = true;
  
  // Dental Specific
  static const int maxFamilyMembers = 6;
  static const Duration analysisTimeout = Duration(minutes: 5);
  static const int maxImagesPerAnalysis = 3;
}