// C:\Users\USER\smileatlas_app\lib\src\screens\home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/family_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/profile_card.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final familyProvider = Provider.of<FamilyProvider>(context);
    final familyMembers = familyProvider.familyMembers;

    return Scaffold(
      appBar: AppBar(
        // Display the family name from provider
        title: Text(familyProvider.familyName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit the family name
              Navigator.pushNamed(context, AppRoutes.editFamily);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: familyMembers.isEmpty
            ? const Center(child: Text("No family members added yet."))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.medium,
                  mainAxisSpacing: AppSpacing.medium,
                ),
                itemCount: familyMembers.length,
                itemBuilder: (context, index) {
                  final member = familyMembers[index];
                  return ProfileCard(
                    name: member.name,
                    imagePath: member.profileImage,
                    onTap: () {
                      // Go to ProfileScreen, passing the member object
                      Navigator.pushNamed(
                        context,
                        AppRoutes.profile,
                        arguments: member,
                      );
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        // Go to add/edit member screen with no existing user => add new
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEditMember);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
