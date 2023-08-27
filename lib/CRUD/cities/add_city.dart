// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';
import '../../main.dart';
import '../../models/governorate.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  late var _governorateIdController;
  late final  Future<List<Governorate>> _governoratesFuture;
  late Uint8List _imageBytes = Uint8List(0);
  var result;
  // ignore: unused_field
  File? _image;
  late final pickedFile;
  late var _selectedGovernorate ;

Future<void> _submitForm() async {
    
    if (_formKey.currentState!.validate()){
    // Send the photo bytes to the API
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/City/upload-photo'),
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
        Uri.parse('$baseUrl/City/create'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'name': _nameController.text,
          'description': _descriptionController.text,
          'picture': result.fileName ?? 'image not found',
          'governerateId': _governorateIdController,
        },
      );
      if (response1.statusCode == 201||response1.statusCode == 200) {
        debugPrint("success");
        Navigator.pushReplacementNamed(context,'/cities');
      } else {
        debugPrint("fail");
        //print(response1.statusCode);
      }
   }
}  
  
    Future<void> _getImage() async {
     result = await ImagePickerWeb.getImageInfo;
    if (result != null) {
      setState(() {
        _imageBytes = result.data!;
      });
    }
  }

  Future<List<Governorate>> getRequest() async {
    // Make a get request to the records from the API
    final response = await http.get(Uri.parse('$baseUrl/Governorate/getAll'));
    var responseData = json.decode(response.body);

    List<Governorate> governorates = [];
    for (var gov in responseData) {
      Governorate governorate = Governorate.fromJson(gov);
      governorates.add(governorate);
    }
    return governorates;
  }

  @override
  void initState() {
    super.initState();
    _governoratesFuture = getRequest(); // Initialize the future in initState
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add City'),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                //name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                //description
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                //image
                ElevatedButton.icon(
                  onPressed: _getImage,
                  icon: const Icon(Icons.photo),
                  label: const Text('Pick an image'),
                ),
                SizedBox(height: 16),
                //governorateID
                FutureBuilder(
                  future:_governoratesFuture ,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
                    
                    if (snapshot.data == null) {
                      return
                      TextButton(onPressed: () {  },
                      child: const Text("loading.."),
        
                      );
                    }
                    else{
                    _selectedGovernorate=snapshot.data[0];
                   return DropdownButtonFormField<Governorate>(
                    
                    items: snapshot.data!.map((gov) => DropdownMenuItem<Governorate>(value: gov as Governorate, child: Text(gov.name))).toList().cast<DropdownMenuItem<Governorate>>(),
                    decoration: InputDecoration(labelText: 'Governorate'),
                    onChanged: (value) {
                      setState(() {
                        _selectedGovernorate = value;
                        _governorateIdController=_selectedGovernorate.id.toString();
                      });
                    },
                    value: _selectedGovernorate,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a Governorate';
                      }
                      return null;
                    },
                  );
                    }
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
