import 'package:flutter_test/flutter_test.dart';
import 'package:smileatlas_app/src/app.dart';
import 'package:provider/provider.dart';
import 'package:smileatlas_app/src/providers/user_provider.dart';
import 'package:smileatlas_app/src/providers/family_provider.dart';
import 'package:smileatlas_app/src/providers/dental_analysis_provider.dart';
import 'package:smileatlas_app/src/providers/dental_image_provider.dart';

void main() {
  testWidgets('SmileAtlas app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => FamilyProvider()),
          ChangeNotifierProvider(create: (_) => DentalAnalysisProvider()),
          ChangeNotifierProvider(create: (_) => DentalImageProvider()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that the app starts with the onboarding screen
    expect(find.text('Welcome to SmileAtlas'), findsOneWidget);
    expect(find.text("Mapping your family's smile journey with precision and care."), findsOneWidget);

    // You can add more widget tests here as needed
  });
}