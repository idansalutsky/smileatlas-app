// lib/src/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<Widget> onboardingPages = [
    const OnboardingPage(
      image: 'assets/images/onboard_welcome.png',
      title: "Welcome to SmileAtlas",
      description: "Mapping your family’s smile journey with precision and care.",
    ),
    const OnboardingPage(
      image: 'assets/images/onboard_personalize.png',
      title: "Personalize Your Experience",
      description: "Create profiles for every family member and track progress over time.",
    ),
    const OnboardingPage(
      image: 'assets/images/onboard_secure.png',
      title: "Secure & Intelligent",
      description: "Leverage AI-powered analysis for insights and reminders.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (index) => setState(() => currentPage = index),
              itemBuilder: (context, index) => onboardingPages[index],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(onboardingPages.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: currentPage == index ? 12 : 8,
                height: currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index ? AppColors.accent : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.medium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: ElevatedButton(
              onPressed: () {
                if (currentPage == onboardingPages.length - 1) {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                } else {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                }
              },
              child: Text(currentPage == onboardingPages.length - 1 ? "Get Started" : "Next"),
            ),
          ),
          const SizedBox(height: AppSpacing.large),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({super.key, required this.image, required this.title, required this.description});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: AppSpacing.large),
          Text(title, style: AppTypography.header, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.small),
          Text(description, style: AppTypography.body, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
