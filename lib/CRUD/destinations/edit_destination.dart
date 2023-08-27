// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:my_flutter/models/destination.dart';

import '../../main.dart';
import '../../models/city.dart';

class EditDestination extends StatefulWidget {
  const EditDestination({super.key});

  @override
  _EditDestinationState createState() => _EditDestinationState();
}

class _EditDestinationState extends State<EditDestination> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController=TextEditingController();
  final _addressController = TextEditingController();
  final _themeController = TextEditingController();
  late var _cityIdController ;
   late var ID;

  late final  Future<List<City>> _citiesFuture;
  // ignore: unused_field
  File? _image;
  late final pickedFile;
  late var _selectedCity ;
  final List<String> _base64Images = [];
  List<String> photoNames = [];



Future<void> _submitForm() async {
    
    if (_formKey.currentState!.validate()){
      try
     { if (_base64Images.isNotEmpty){
    // Create a new multipart request
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/Destination/upload-photos'));

    // Add the photos to the request as multipart/form-data
    for (var i = 0; i < _base64Images.length; i++) {
      var bytes = base64.decode(_base64Images[i]);
      var fileName = photoNames[i];
      var multipartFile = http.MultipartFile.fromBytes('photos', bytes, filename: fileName);
      request.files.add(multipartFile);
    }

    // Send the request and get the response
    var response = await request.send();

    // Check if the response was successful
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
    } else {
      print('Error: ${response.statusCode}');
    }
      }
    
    //sending the create request
    final url = '$baseUrl/Destination/update?id=$ID';
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'cityId': _cityIdController,
      'theme':_themeController.text,
      'address':_addressController.text,
      for (int i = 0; i < photoNames.length; i++) 
        'SelectedPictures[$i]': photoNames[i],
    };
    print("1");
     final response1 = await http.put(Uri.parse(url), headers: headers, body: body);
      if (response1.statusCode == 201||response1.statusCode == 200) {
        debugPrint("success");
        Navigator.pushReplacementNamed(context,'/destinations');
      } else {
        debugPrint("fail");
        print('Error: ${response1.statusCode}');
        print('Error: ${response1.body}');
      }
      }catch(e){debugPrint(e.toString());}
   }
}  
  
Future<void> _selectImages() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );

    if (result != null) {
      List<PlatformFile> files = result.files;

      for (PlatformFile file in files) {
        List<int> imageData = file.bytes!;
        photoNames.add(file.name);
        print(file.name);
        String base64Image = base64Encode(imageData);
        setState(() {
          _base64Images.add(base64Image);
        });
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}


  Future<List<City>> getRequest() async {
    // Make a get request to the records from the API
    final response = await http.get(Uri.parse('$baseUrl/City/getAll'));
    var responseData = json.decode(response.body);

    List<City> cities = [];
    for (var gov in responseData) {
      City city = City.fromJson(gov);
      cities.add(city);
    }
    return cities;
  }

  @override
  void initState() {
    super.initState();
    _citiesFuture = getRequest(); // Initialize the future in initState
  }


  @override
  Widget build(BuildContext context) {
    final Destination gov = ModalRoute.of(context)!.settings.arguments as Destination;
    ID=gov.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Destination'),
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
                  decoration: InputDecoration(labelText: 'Desciption'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                //address
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                //theme
                TextFormField(
                  controller: _themeController,
                  decoration: InputDecoration(labelText: 'Theme'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a theme';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                //image
                ElevatedButton.icon(
                  onPressed: _selectImages,
                  icon: const Icon(Icons.photo),
                  label: const Text('Pick an image'),
                ),
                SizedBox(height: 16),
                //governorateID
                FutureBuilder(
                  future:_citiesFuture ,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
                    
                    if (snapshot.data == null) {
                      return
                      TextButton(onPressed: () {  },
                      child: const Text("loading.."),
        
                      );
                    }
                    else{
                    _selectedCity=snapshot.data[0];
                   return DropdownButtonFormField<City>(
                    
                    items: snapshot.data!.map((gov) => DropdownMenuItem<City>(value: gov as City, child: Text(gov.name))).toList().cast<DropdownMenuItem<City>>(),
                    decoration: InputDecoration(labelText: 'City'),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                        _cityIdController=_selectedCity.id.toString();
                      });
                    },
                    value: _selectedCity,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a City';
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
