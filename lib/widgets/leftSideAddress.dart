// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LeftSideAddress extends StatelessWidget {
  final String title;
  final double fontSize;
  const LeftSideAddress({
    super.key,
    required this.title,
    required this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,  
        width: 300,
        child: Text( title,
            style: TextStyle( fontSize: fontSize,
              fontWeight: FontWeight.bold,  
              color: Colors.grey[800]  
            ),
            textAlign: TextAlign.left,
      ),
      );
  }
}