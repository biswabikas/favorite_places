import 'package:favoriteplaces/providers/user_places.dart';
import 'package:favoriteplaces/widgets/image_input.dart';
import 'package:favoriteplaces/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final titlecontroller = TextEditingController();
  File? selectedimage;
  @override
  void dispose() {
    // TODO: implement dispose
    titlecontroller.dispose();
    super.dispose();
  }

  void saveplace() {
    final enteredtitile = titlecontroller.text;
    if (enteredtitile.isEmpty) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredtitile, selectedimage!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Form(
                child: TextFormField(
                  controller: titlecontroller,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              ImageInput(
                onpickimage: (image) {
                  selectedimage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const LocationInput(),
              ElevatedButton.icon(
                onPressed: saveplace,
                icon: const Icon(Icons.add),
                label: const Text('Add place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
