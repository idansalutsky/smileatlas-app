// C:\Users\USER\smileatlas_app\lib\src\screens\upload_image_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class UploadImageScreen extends StatefulWidget {
  final String memberId;

  const UploadImageScreen({Key? key, required this.memberId}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();

  File? _frontImage;
  File? _upperImage;
  File? _lowerImage;
  bool _isUploading = false;
  String _errorMessage = '';

  Future<void> _pickImage(String type) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        final file = File(pickedFile.path);
        if (type == 'front') {
          _frontImage = file;
        } else if (type == 'upper') {
          _upperImage = file;
        } else if (type == 'lower') {
          _lowerImage = file;
        }
      });
    }
  }

  Future<void> _uploadImages() async {
    if (_frontImage == null || _upperImage == null || _lowerImage == null) {
      setState(() {
        _errorMessage = "Please capture all three images before uploading.";
      });
      return;
    }
    setState(() {
      _isUploading = true;
      _errorMessage = '';
    });
    try {
      // This calls your custom API endpoint. Make sure it's implemented:
      final result = await _apiService.uploadDentalImages(
        _frontImage!,
        _upperImage!,
        _lowerImage!,
        widget.memberId,
      );
      // Show success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Images uploaded successfully.")),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Dental Images - ${widget.memberId}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: AppColors.error),
                ),
              const SizedBox(height: AppSpacing.medium),

              // Front
              _frontImage != null
                  ? Image.file(_frontImage!, height: 150)
                  : const Text("No front image selected"),
              ElevatedButton(
                onPressed: () => _pickImage('front'),
                child: const Text("Capture Front Image"),
              ),
              const SizedBox(height: AppSpacing.medium),

              // Upper
              _upperImage != null
                  ? Image.file(_upperImage!, height: 150)
                  : const Text("No upper image selected"),
              ElevatedButton(
                onPressed: () => _pickImage('upper'),
                child: const Text("Capture Upper Image"),
              ),
              const SizedBox(height: AppSpacing.medium),

              // Lower
              _lowerImage != null
                  ? Image.file(_lowerImage!, height: 150)
                  : const Text("No lower image selected"),
              ElevatedButton(
                onPressed: () => _pickImage('lower'),
                child: const Text("Capture Lower Image"),
              ),
              const SizedBox(height: AppSpacing.large),

              ElevatedButton(
                onPressed: _isUploading ? null : _uploadImages,
                child: _isUploading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text("Upload & Analyze"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
