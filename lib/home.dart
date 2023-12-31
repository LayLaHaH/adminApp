// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_flutter/providers/token.dart';
import 'package:my_flutter/widgets/appBar.dart';
import 'package:my_flutter/widgets/mySideBar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body:Row(
        children: [
          MySideBar(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                  child:Text("Welocome"),
                )
              )
            )
          )
        ]
      )
    );
  }
}