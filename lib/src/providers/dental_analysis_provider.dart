import 'package:flutter/material.dart';
import '../models/dental_analysis.dart';

class DentalAnalysisProvider extends ChangeNotifier {
  // Map key can be a member ID or image ID.
  final Map<String, DentalAnalysis> _analysisResults = {};

  Map<String, DentalAnalysis> get analysisResults => _analysisResults;

  void setAnalysis(String key, DentalAnalysis analysis) {
    _analysisResults[key] = analysis;
    notifyListeners();
  }

  DentalAnalysis? getAnalysis(String key) {
    return _analysisResults[key];
  }

  void clearAnalysis() {
    _analysisResults.clear();
    notifyListeners();
  }
}
