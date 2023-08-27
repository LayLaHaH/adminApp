// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:my_flutter/models/hotel.dart';

import '../../main.dart';
import '../../models/city.dart';

class EditHotel extends StatefulWidget {
  const EditHotel({super.key});

  @override
  _EditHotelState createState() => _EditHotelState();
}

class _EditHotelState extends State<EditHotel> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _urlController = TextEditingController();
  final _addressController = TextEditingController();
  final _starController = TextEditingController();
  late var _cityIdController ;
  late var ID;

  late final  Future<List<City>> _citiesFuture;
  late Uint8List _imageBytes = Uint8List(0);
  var result;
  // ignore: unused_field
  File? _image;
  late final pickedFile;
  late var _selectedCity ;

Future<void> _submitForm() async {
    
    if (_formKey.currentState!.validate()){
    // Send the photo bytes to the API
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/Hotel/upload-photo'),
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
    try{
      final response1 = await http.put(
        Uri.parse('$baseUrl/Hotel/update?id=$ID'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'name': _nameController.text,
          'contactNumber': _contactController.text,
          'image': result.fileName ?? 'image not found',
          'cityId': _cityIdController,
          'url':_urlController.text,
          'address':_addressController.text,
          'classStar':_starController.text,
        },
      );
      if (response1.statusCode == 201||response1.statusCode == 200) {
        debugPrint("success");
        Navigator.pushReplacementNamed(context,'/hotels');
      } else {
        debugPrint("fail");
        //print(response1.statusCode);
      }
    }catch(e){
      debugPrint(e.toString());
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
    final Hotel gov = ModalRoute.of(context)!.settings.arguments as Hotel;
    ID=gov.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Hotel'),
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
                //contact number
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a contact number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                //url
                TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(labelText: 'URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a url';
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
                //class star
                SizedBox(height: 16),
                TextFormField(
                  controller: _starController,
                  decoration: InputDecoration(labelText: 'Class Stars'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the class stars';
                    }
                    if(value!="1"&&value!="2"&&value!="3"&&value!="4"&&value!="5"){
                      return 'Please enter a value between 1 and 5';
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
