import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.onSelectedImage});
  final void Function(File image) onSelectedImage;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectImage;
  _takePicture() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage != null) {
      setState(() {
        _selectImage = File(pickedImage.path);
        widget.onSelectedImage(_selectImage!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: () {
          _takePicture();
        },
        icon:
            Icon(Icons.camera, color: Theme.of(context).colorScheme.onSurface),
        label: Text(
          'pick picture',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ));
    if (_selectImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        alignment: Alignment.center,
        child: content);
  }
}
