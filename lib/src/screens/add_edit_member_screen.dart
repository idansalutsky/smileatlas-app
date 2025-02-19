// lib/src/screens/add_edit_member_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/family_provider.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class AddEditMemberScreen extends StatefulWidget {
  final UserModel? member; // if null, we are adding

  const AddEditMemberScreen({Key? key, this.member}) : super(key: key);

  @override
  State<AddEditMemberScreen> createState() => _AddEditMemberScreenState();
}

class _AddEditMemberScreenState extends State<AddEditMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  late String _name;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    // If we're editing, preload the name and image
    if (widget.member != null) {
      _name = widget.member!.name;
      _imagePath = widget.member!.profileImage;
    } else {
      _name = '';
      _imagePath = 'assets/images/default.png'; // or some fallback
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _saveMember() {
    if (_formKey.currentState!.validate()) {
      final familyProvider = Provider.of<FamilyProvider>(context, listen: false);

      if (widget.member != null) {
        // Editing existing member
        final updated = UserModel(
          id: widget.member!.id,
          name: _name.trim(),
          profileImage: _pickedImage?.path ?? _imagePath,
          latestAnalysis: widget.member!.latestAnalysis,
        );
        familyProvider.updateMember(updated);
      } else {
        // Creating a new member
        final newId = const Uuid().v4();
        final newMember = UserModel(
          id: newId,
          name: _name.trim(),
          profileImage: _pickedImage?.path ?? 'assets/images/default.png',
          latestAnalysis: null,
        );
        familyProvider.addMember(newMember);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.member != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Member" : "Add Member")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Show picked image if available
              if (_pickedImage != null)
                Image.file(
                  _pickedImage!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              else
                Image.asset(
                  _imagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),

              const SizedBox(height: AppSpacing.small),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text("Pick Profile Image"),
              ),

              const SizedBox(height: AppSpacing.medium),
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => _name = val,
              ),

              const SizedBox(height: AppSpacing.large),
              ElevatedButton(
                onPressed: _saveMember,
                child: Text(isEditing ? "Save Changes" : "Add Member"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
