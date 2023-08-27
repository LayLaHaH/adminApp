// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
class MultiTextField extends StatefulWidget {
  String label='';
  
  List<TextEditingController> Controllers = [TextEditingController()];
   MultiTextField({super.key,required this.Controllers,required this.label});

  @override
  State<MultiTextField> createState() => _MultiTextFieldState();
}

class _MultiTextFieldState extends State<MultiTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: widget.label,
                    ),
                    controller: widget.Controllers[0],
                  ),
                ),
                TextButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      widget.Controllers.add(TextEditingController());
                    });
                  },
                ),
              ],
            ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.Controllers.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return TextFormField(
                    controller: widget.Controllers[index + 1],
                  );
          },
        ),
      ],
    ); }
}