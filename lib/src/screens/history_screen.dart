import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dental Analysis History")),
      body: PageView(
        children: [
          CurrentAnalysisScreen(),
          PastAnalysisScreen(),
        ],
      ),
    );
  }
}

class CurrentAnalysisScreen extends StatelessWidget {
  const CurrentAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with production logic to fetch and display the current analysis.
    return const Center(child: Text("Current Analysis Result", style: AppTypography.header));
  }
}

class PastAnalysisScreen extends StatelessWidget {
  const PastAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with production logic to display historical analysis.
    return const Center(child: Text("Past Analysis History", style: AppTypography.header));
  }
}
