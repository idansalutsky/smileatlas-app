import 'package:flutter/material.dart';
import '../models/dental_analysis.dart';
import '../utils/constants.dart';

class DentalMapWidget extends StatelessWidget {
  final DentalAnalysis? analysis;
  
  const DentalMapWidget({
    super.key,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    if (analysis == null) {
      return const Center(
        child: Text('No dental analysis available'),
      );
    }

    return CustomPaint(
      size: const Size(double.infinity, 200),
      painter: _DentalMapPainter(analysis: analysis!),
    );
  }
}

class _DentalMapPainter extends CustomPainter {
  final DentalAnalysis analysis;
  
  _DentalMapPainter({
    required this.analysis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the dental arch schematic
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    path.moveTo(20, size.height * 0.8);
    path.quadraticBezierTo(size.width / 2, 0, size.width - 20, size.height * 0.8);
    canvas.drawPath(path, paint);

    // Overlay markers computed from analysis
    final markerPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;
    
    for (var marker in analysis.markers) {
      canvas.drawCircle(
        Offset(marker.dx * size.width, marker.dy * size.height), 
        6, 
        markerPaint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}