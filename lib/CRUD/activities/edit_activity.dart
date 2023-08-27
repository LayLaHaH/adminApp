//import 'dart:convert';
// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names


import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:http/http.dart' as http;
import 'package:my_flutter/models/activity.dart';

import '../../main.dart';

class EditActivity extends StatefulWidget {
  const EditActivity({super.key});

  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  late  DateTime _opennigHourController = DateTime.now();
  late  DateTime _closingHourController = DateTime.now();
  late  DateTime _opennigDayController = DateTime.now();
  late  DateTime _closingDayController = DateTime.now();
  late var ID;
  late Uint8List _imageBytes = Uint8List(0);
  var result;
    ////late final  Future<List<Governorate>> _governoratesFuture;


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Send the photo bytes to the API
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/Activity/upload-photo'),
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
       final response1 = await http.put(
        Uri.parse('$baseUrl/Activity/update?id=$ID'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'name': _nameController.text,
          'description': _descriptionController.text,
          'image': result.fileName ?? 'image not found',
          'price':_priceController.text,
          'startTime' :_opennigHourController.toIso8601String(),
          'closeTime':_closingHourController.toIso8601String(),
          'startingDay':_opennigDayController.toIso8601String(),
          'endingDay':_closingDayController.toIso8601String(),
        },
      );
      if (response1.statusCode == 200||response1.statusCode == 201) {
        debugPrint('success');
        Navigator.pushReplacementNamed(context,'/activities');
      } else {
        debugPrint('Error creating activity: ${response1.reasonPhrase}');
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
    final Activity gov = ModalRoute.of(context)!.settings.arguments as Activity;
    ID=gov.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Activity')),
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
                    //price
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a price.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    //oppening hours
                    Row(
                      children: [
                        SizedBox(width: 55,),
                        ElevatedButton.icon(
                          onPressed:() async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1))),
                            );
                            if (pickedTime != null) {
                              setState(() => _opennigHourController = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  ));
                            }
                          },
                          icon: const Icon(Icons.access_time),
                          label: const Text('Opening Hour'),
                        ),
                        SizedBox(width: 55,),
                        ElevatedButton.icon(
                          onPressed:() async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1))),
                            );
                            if (pickedTime != null) {
                              setState(() => _closingHourController = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  ));
                            }
                          },
                          icon: const Icon(Icons.access_time),
                          label: const Text('Closing Hour'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    //oppening days
                    Row(
                      children: [
                        SizedBox(width: 55,),
                        ElevatedButton.icon(
                          onPressed:() async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 10),
                            );
                            if (pickedDate != null) {
                              setState(() => _opennigDayController = pickedDate);
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Opening Date'),
                        ),
                        SizedBox(width: 55,),
                        ElevatedButton.icon(
                          onPressed:() async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 10),
                            );
                            if (pickedDate != null) {
                              setState(() => _closingDayController = pickedDate);
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Closing Date'),
                        ),
                      ],
                    ),
SizedBox(height: 16,),
                    //image
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.photo),
                      label: const Text('Pick an image'),
                    ),
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