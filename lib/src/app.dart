import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart'; // for tr(), etc.

import 'routes/app_routes.dart';
import 'providers/user_provider.dart';
import 'providers/family_provider.dart';
import 'providers/dental_analysis_provider.dart';
import 'providers/dental_image_provider.dart';
import 'utils/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // constructor

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FamilyProvider()),
        ChangeNotifierProvider(create: (_) => DentalAnalysisProvider()),
        ChangeNotifierProvider(create: (_) => DentalImageProvider()),
      ],
      child: MaterialApp(
        title: tr('app_title'), // <--- from your JSONs
        debugShowCheckedModeBanner: false,

        // easy_localization settings
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,

        theme: ThemeData(
          primaryColor: AppColors.primary,
          colorScheme: const ColorScheme.light(secondary: AppColors.accent),
          scaffoldBackgroundColor: AppColors.background,
          textTheme: const TextTheme(
            titleLarge: AppTypography.header,
            bodyMedium: AppTypography.body,
          ),
        ),
        initialRoute: AppRoutes.onboarding,
        routes: AppRoutes.routes,
      ),
    );
  }
}
