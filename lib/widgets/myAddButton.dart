

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class myAddButton extends StatelessWidget {
  final label;
  final route;
  final maxwidth;
  const myAddButton({
    super.key,
    required this.label,
    required this.route,
    required this.maxwidth
  });

  @override
  Widget build(BuildContext context) {
    return Align(
  alignment: Alignment.topLeft,
  child: GestureDetector(
    onTap: (){Navigator.pushNamed(context, route);},
    child: Container(
      height: 50.0,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 160, 6, 73), Color.fromARGB(255, 238, 139, 172)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: maxwidth, minHeight: 50.0),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,0,0,0),
          child: Row(
            children: [
              Icon(Icons.add,color: Colors.white,),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),  
            ],
          ),
        ),
      ),
    ),
  ),
);
  }
}

