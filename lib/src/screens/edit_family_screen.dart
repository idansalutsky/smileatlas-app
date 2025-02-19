// lib/src/screens/edit_family_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/family_provider.dart';
import '../utils/constants.dart';

class EditFamilyScreen extends StatefulWidget {
  const EditFamilyScreen({Key? key}) : super(key: key);

  @override
  State<EditFamilyScreen> createState() => _EditFamilyScreenState();
}

class _EditFamilyScreenState extends State<EditFamilyScreen> {
  final _formKey = GlobalKey<FormState>();
  String _newName = '';

  @override
  Widget build(BuildContext context) {
    final familyProvider = Provider.of<FamilyProvider>(context, listen: false);
    _newName = familyProvider.familyName;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Family Name")),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _newName,
                decoration: const InputDecoration(labelText: 'Family Name'),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a family name';
                  }
                  return null;
                },
                onChanged: (val) => _newName = val.trim(),
              ),
              const SizedBox(height: AppSpacing.large),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    familyProvider.setFamilyName(_newName);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
