import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/widgets/image_picker.dart';
import 'package:places/widgets/location.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _ConsumerAddPlaceScreenState();
}

class _ConsumerAddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  PlaceLocation? _location;

  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final title = _titleController.text;
    if (title == '') {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Title',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              content: Text(
                'Enter The Title',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ok'))
              ],
            );
          });
    }
    if (title == "" || _selectedImage == null || _selectedImage == null) {
      return;
    }
    ref
        .watch(userPlaceProvider.notifier)
        .addPlace(title, _selectedImage!, _location!);
    Navigator.pop(context);

    print('$title added successfully');
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Title",
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface)),
            ),
            SizedBox(
              height: 10,
            ),
            ImagePickerWidget(
              onSelectedImage: (File image) {
                _selectedImage = image;
              },
            ),
            SizedBox(
              height: 10,
            ),
            LocationWidget(
              onSelectLocation: (PlaceLocation location) {
                _location = location;
              },
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  _savePlace();
                },
                icon: Icon(Icons.add,
                    color: Theme.of(context).colorScheme.onSurface),
                label: Text(
                  'Add Place',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ))
          ],
        ),
      ),
    );
  }
}
