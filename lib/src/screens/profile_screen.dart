// C:\Users\USER\smileatlas_app\lib\src\screens\profile_screen.dart

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/dental_map_widget.dart';
import '../utils/constants.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  // Make this nullable to handle cases where no valid user was passed
  final UserModel? member;

  const ProfileScreen({Key? key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fallback if member is null
    final currentMember = member ?? UserModel(
      id: 'unknown',
      name: 'Unknown',
      profileImage: 'assets/images/default.png',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("${currentMember.name}'s Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Go to add/edit member, passing the current user
              Navigator.pushNamed(
                context,
                AppRoutes.addEditMember,
                arguments: currentMember,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display basic member info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(currentMember.profileImage),
                  radius: 40,
                ),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentMember.name, style: AppTypography.header),
                      if (currentMember.latestAnalysis != null &&
                          currentMember.latestAnalysis!.teeth.isNotEmpty)
                        Text(
                          'Teeth Analyzed: ${currentMember.latestAnalysis!.teeth.length}',
                          style: AppTypography.caption,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.large),

            // Quick header for analysis or a "Start New" button if none
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dental Analysis", style: AppTypography.subheader),
                if (currentMember.latestAnalysis == null)
                  TextButton(
                    onPressed: () {
                      // Trigger new analysis by going to upload images
                      Navigator.pushNamed(
                        context,
                        AppRoutes.uploadImage,
                        arguments: currentMember.id,
                      );
                    },
                    child: const Text("Start New Analysis"),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.medium),

            // Show the dental map if an analysis is present
            Expanded(
              child: Center(
                child: currentMember.latestAnalysis == null
                    ? const Text('No recent analysis')
                    : DentalMapWidget(analysis: currentMember.latestAnalysis),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Another route to upload images
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.uploadImage,
            arguments: currentMember.id,
          );
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
