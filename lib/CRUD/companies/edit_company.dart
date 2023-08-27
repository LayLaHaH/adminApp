//import 'dart:convert';
// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:my_flutter/models/company.dart';

import '../../main.dart';

class EditCompany extends StatefulWidget {
  const EditCompany({super.key});

  @override
  _EditCompanyState createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();
  late var ID;


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Send the photo bytes to the API
     
      //sending the create request
       final response1 = await http.put(
        Uri.parse('$baseUrl/TourCompany/update?id=$ID'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'name': _nameController.text,
          'contactNumber': _numberController.text,
          'address':_addressController.text
        },
      );
      if (response1.statusCode == 200) {
        debugPrint('success');
        Navigator.pushReplacementNamed(context,'/companies');
      } else {
        debugPrint('Error creating company: ${response1.reasonPhrase}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final Company gov = ModalRoute.of(context)!.settings.arguments as Company;
    ID=gov.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Company')),
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
                    //number
                    TextFormField(
                      controller: _numberController,
                      decoration: const InputDecoration(labelText: 'Contact Number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the contact number.';
                        }
                        return null;
                      },
                    ),
                    //address
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the address.';
                        }
                        return null;
                      },
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