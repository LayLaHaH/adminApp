//import 'dart:convert';
// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously


import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:http/http.dart' as http;

import '../../main.dart';

class AddGovernorate extends StatefulWidget {
  const AddGovernorate({super.key});

  @override
  _AddGovernorateState createState() => _AddGovernorateState();
}

class _AddGovernorateState extends State<AddGovernorate> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  late Uint8List _imageBytes = Uint8List(0);
  var result;
    ////late final  Future<List<Governorate>> _governoratesFuture;


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Send the photo bytes to the API
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/Governorate/upload-photo'),
      );
      final photoPart = http.MultipartFile.fromBytes(
        'photo',
        _imageBytes,
        filename: result.fileName,

      );
      request.files.add(photoPart);
      request.fields['photoName'] = result.fileName;
      final response = await request.send();
      if (response.statusCode == 200) {
        debugPrint('Photo uploaded successfully!');
      } else {
        debugPrint('Error uploading photo: ${response.reasonPhrase}');
      }

      // Check the response status code
      if (response.statusCode == 200) {
        debugPrint('Photo uploaded successfully!');

      } else {
        debugPrint('Error uploading photo: ${response.reasonPhrase}');
      }


      //sending the create request
       final response1 = await http.post(
        Uri.parse('$baseUrl/Governorate/create'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'name': _nameController.text,
          'description': _descriptionController.text,
          'picture': result.fileName ?? 'image not found',
        },
      );
      if (response1.statusCode == 200) {
        debugPrint('success');
        Navigator.pushReplacementNamed(context,'/govs');
      } else {
        debugPrint('Error creating governorate: ${response1.reasonPhrase}');
      }
    }
  }

  Future<void> _pickImage() async {
     result = await ImagePickerWeb.getImageInfo;
    if (result != null) {
      setState(() {
        _imageBytes = result.data!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add governorate')),
      body: ListView(
        children:[ Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name.';
                        }
                        return null;
                      },
                    ),
                    //description
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    //image
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.photo),
                      label: const Text('Pick an image'),
                    ),
                    if (_imageBytes.isNotEmpty)
                      Image.memory(_imageBytes),
                    SizedBox(height: 16,),  
                    ElevatedButton(
                      onPressed: _submitForm ,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),]
      ),
    );
  }
}