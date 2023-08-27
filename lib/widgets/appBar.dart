// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pink[800],
      leading: IconButton(
        onPressed: () { Navigator.popUntil(context, (route) => route.isFirst); },
        //onHover: ,
        icon: Icon(Icons.home)
        ),
      centerTitle: true,
      
      
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}