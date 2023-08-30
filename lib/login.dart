// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_flutter/main.dart';
import 'package:my_flutter/providers/token.dart';
import 'package:my_flutter/widgets/appBar.dart';
import 'package:my_flutter/widgets/mySideBar.dart';
  import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visible = isVisible;
  late var role;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

Future<void> login() async {


  var url = Uri.parse('$baseUrl/Authentication/Login'); // Replace with the actual API endpoint
try{
  var response = await http.post(
    url,
    body: {
      'Email': _emailController.text, // Replace with the email
      'Password': _passwordController.text, // Replace with the password
    },
  );

  if (response.statusCode == 200) {
    // Request was successful
    var responseBody = response.body;

    // Parse the response body to get the token
    var parsedResponse = jsonDecode(responseBody);
    var token = parsedResponse['token'];
    Provider.of<Token>(context, listen: false).updateToken(token);

    // Get the role from the token
     
     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
     
     var role = decodedToken['role'];
     if (role=="Admin")
     {
       Navigator.pushNamed(context,'/home');
     }
     

    
  } else {
    // Request failed
    print('Request failed with status: ${response.statusCode}');
  }
  }catch(e){
    debugPrint("$e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.pink[800],),
      body: Stack(
        children:[
          Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("Assets/Caasdadpture.JPG"), fit: BoxFit.cover,),
          ),
          ),
           Row(
          children: [
            
            Expanded(
              child: Center(
                child: Container(
                  height: 500,
                  width: 500,
                  //color: Color.fromARGB(0, 189, 186, 186), // Make the container transparent
                  child: Center(
                    child:
                         Card(
                            margin: EdgeInsets.all(16.0),
                            color: Color.fromARGB(0, 235, 231, 231), // Make the card transparent
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _passwordController,
                                    style: TextStyle(color: Colors.white),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.0),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      //shadowColor: Color.fromARGB(255, 76, 33, 145),
                                      backgroundColor: Color.fromARGB(255, 99, 17, 51),
                                    ),
                                    onPressed: login,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ]
      ),
    );
  }
}

