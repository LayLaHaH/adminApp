// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

class DeleteConfirmation extends StatefulWidget {
  const DeleteConfirmation({super.key});

  @override
  State<DeleteConfirmation> createState() => _DeleteConfirmationState();
}

class _DeleteConfirmationState extends State<DeleteConfirmation> {

  // this function is called when the Cancel button is pressed
    void _cancel() {
    Navigator.pop(context,false);
  }

  // this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context,true);
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: const Text('Delete Item'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning, color: Colors.red, size: 50),
                const SizedBox(height: 16),
                Text(
                  'Are you sure you want to delete this item?',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: _cancel,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 173, 20, 87)),
                ),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submit,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 173, 20, 87)),
                ),
                child: const Text('Delete'),
              ),
            ],
          );
  }
}