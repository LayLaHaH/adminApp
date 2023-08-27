// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.nameController,
    required this.erreMessage,
    required this.label
  }) ;

  final TextEditingController nameController;
  final  label;
  final erreMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return erreMessage;
        }
        return null;
      },
    );
  }
}