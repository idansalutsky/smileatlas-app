import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/constants.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File) onImageSelected;
  const ImagePickerWidget({super.key, required this.onImageSelected});
  
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectedImage != null
            ? Image.file(_selectedImage!, height: 150)
            : Container(
                height: 150,
                color: Colors.grey.shade300,
                child: const Center(child: Text("No image selected")),
              ),
        const SizedBox(height: AppSpacing.medium),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text("Camera"),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text("Gallery"),
            ),
          ],
        ),
      ],
    );
  }
}
