// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:my_flutter/providers/token.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
   MyAppBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pink[800],
      leading: IconButton(
        onPressed: () {  Navigator.pushNamed(context,'/home'); },
        //onHover: ,
        icon:  Icon(Icons.home)
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              //shadowColor: Color.fromARGB(255, 76, 33, 145),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: (){  Navigator.popUntil(context, (route) => route.isFirst);
                            Navigator.pushNamed(context,'/');
                            Provider.of<Token>(context, listen: false).updateToken('logged out');
                           },
            child: Text(
              ' LogOut ',
              style: TextStyle(color: Color.fromARGB(255, 99, 17, 51),fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
      
      
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}