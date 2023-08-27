// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, camel_case_types, file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_flutter/models/company.dart';
import 'package:my_flutter/widgets/appBar.dart';
import 'package:my_flutter/widgets/mySideBar.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../widgets/deleteConfirmation.dart';
import '../../widgets/leftSideAddress.dart';
import '../../widgets/myAddButton.dart';


class CompanySettings extends StatefulWidget {
  const CompanySettings({super.key});

  @override
  State<CompanySettings> createState() => _CompanySettingsState();
}
class _CompanySettingsState extends State<CompanySettings> {

  bool deleteFlag =false;

 Future<List<Company>> getRequest() async {
    // Make a get request to the records from the API
    final response = await http.get(Uri.parse('$baseUrl/TourCompany/getAll'));
    var responseData = json.decode(response.body);

    List<Company> companies = [];
    for (var gov in responseData) {
      Company company = Company.fromJson(gov);
      companies.add(company);
    }
    return companies;
  }  



  void deleteAlert(int? id) async {
    final results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmation();
      },
    );
    // Update UI
    if (results != null && results == true) {
      final response = await http.delete(Uri.parse('$baseUrl/TourCompany/delete?id=$id'));
      if (response.statusCode == 200) {
          Navigator.pushReplacementNamed(context,'/companies'); 
      } else {
        debugPrint("an error accured when deleting this item");
      }
    }
  }


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
          child: Column(
            children:  <Widget>[
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,0),
                child: LeftSideAddress(title:'Company Settings', fontSize: 20.0,),
              ),
              //add button
              myAddButton(label: "Add Company", route: "/addCompany", maxwidth: 170.0,),
              //search
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: Icon(Icons.search,color: Colors.pink[800],),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              //the items
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: FutureBuilder<List<Company>>(
                        future: getRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) =>
                              Container(
                                height: 80,
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(flex: 1,child: Text(snapshot.data![index].id.toString()),),
                                    Expanded(flex: 4,child: Text(snapshot.data![index].name)),
                                    Expanded(flex: 2,child:Row(
                                      children: [
                                        IconButton( icon: Icon(Icons.edit,color: Color.fromARGB(255, 206, 134, 34),),
                                          onPressed: (){Navigator.pushNamed(context, '/editCompany',arguments: snapshot.data![index]);},),
                                        IconButton( icon: Icon(Icons.delete,color: const Color.fromARGB(255, 233, 31, 16),),
                                          onPressed:  () => deleteAlert(snapshot.data![index].id)),
                                      ],
                                     )
                                    ),
                                  ],
                                ),
                              )
                            );
                          }
                           else if (snapshot.hasError) {
                            return Text('Error loading data');
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                        )
              )
          ]
          )
          )
         ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

