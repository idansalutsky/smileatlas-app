import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;
  
  const ProfileCard({super.key, 
    required this.name,
    required this.imagePath,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 40,
              ),
              const SizedBox(height: AppSpacing.medium),
              Text(
                name,
                style: AppTypography.header,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
