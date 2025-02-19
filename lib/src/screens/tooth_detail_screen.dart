import 'package:flutter/material.dart';
import '../models/dental_analysis.dart';
import '../utils/constants.dart';

class ToothDetailScreen extends StatefulWidget {
  final Tooth tooth;
  /// Expects two image paths/URLs: [currentScan, previousScan]
  final List<String> scanImages;
  const ToothDetailScreen({super.key, required this.tooth, required this.scanImages});

  @override
  _ToothDetailScreenState createState() => _ToothDetailScreenState();
}

class _ToothDetailScreenState extends State<ToothDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.scanImages.length, (index) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          width: _currentPage == index ? 12.0 : 8.0,
          height: _currentPage == index ? 12.0 : 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? AppColors.accent : Colors.grey,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail for ${widget.tooth.professionalName}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.scanImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  panEnabled: true,
                  minScale: 1,
                  maxScale: 5,
                  child: Image.asset(
                    widget.scanImages[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
          _buildDotsIndicator(),
          const SizedBox(height: AppSpacing.medium),
        ],
      ),
    );
  }
}
