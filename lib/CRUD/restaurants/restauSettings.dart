// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_flutter/models/restaurant.dart';
import 'package:my_flutter/widgets/appBar.dart';
import 'package:my_flutter/widgets/mySideBar.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../widgets/deleteConfirmation.dart';
import '../../widgets/leftSideAddress.dart';
import '../../widgets/myAddButton.dart';


class RestaurantSettings extends StatefulWidget {
  const RestaurantSettings({super.key});

  @override
  State<RestaurantSettings> createState() => _RestaurantSettingsState();
}
class _RestaurantSettingsState extends State<RestaurantSettings> {

  bool deleteFlag =false;

 Future<List<Restaurant>> getRequest() async {
    // Make a get request to the records from the API
    final response = await http.get(Uri.parse('$baseUrl/Restaurant/getAll'));
    var responseData = json.decode(response.body);
    

    List<Restaurant> restaus = [];
    for (var gov in responseData) {
      try{
      Restaurant restau = Restaurant.fromJson(gov);
      restaus.add(restau);
      
      }
      catch(e){
        debugPrint(e as String?);
      }
    }
    return restaus;
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
      final response = await http.delete(Uri.parse('$baseUrl/Restaurant/delete?id=$id'));
      if (response.statusCode == 200) {
          Navigator.pushReplacementNamed(context,'/restaurants'); 
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
                child: LeftSideAddress(title:'Restaurant Settings', fontSize: 20.0,),
              ),
              //add button
              myAddButton(label: "Add Restaurants", route: "/addRestaurant", maxwidth: 170.0,),
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
              Container(
                  height: 40,
                  color: Color.fromARGB(31, 165, 146, 146),
                  child: Row(  
                    children: [
                      Expanded(flex: 1, child: Text('   ID')),
                      Expanded(flex: 3, child: Text('Name')),
                      Expanded(flex: 3, child: Text('Contact Number')),
                      Expanded(flex: 4, child: Text('Address')),
                      Expanded(flex: 3, child: Text('URL')),
                      Expanded(flex: 2, child: Text('Overview')),
                      Expanded(flex: 2, child: Text('Cuisine')),
                      Expanded(flex: 2, child: Text('Oppening Hour')),
                      Expanded(flex: 2, child: Text('Closing Hour')),
                      Expanded(flex: 2, child: Text('Actions')),
                    ],
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: FutureBuilder<List<Restaurant>>(
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
                                    Expanded(flex: 3,child: Text(snapshot.data![index].name) ),
                                    Expanded(flex: 3, child: Text(snapshot.data![index].contacNumber)),
                                    Expanded(flex: 4, child: Text(snapshot.data![index].address)),
                                    Expanded(flex: 3, child: Text(snapshot.data![index].url.toString())),
                                    Expanded(flex: 2, child: Text(snapshot.data![index].classStar.toString())),
                                    Expanded(flex: 2, child: Text(snapshot.data![index].cuisine)),
                                    Expanded(flex: 2, child: Text('${snapshot.data![index].openingHour.hour.toString()}:${snapshot.data![index].openingHour.minute.toString()}')),
                                    Expanded(flex: 2, child: Text('${snapshot.data![index].closingHour.hour.toString()}:${snapshot.data![index].closingHour.minute.toString()}')),
                                    Expanded(flex: 2,child:Row(
                                      children: [
                                        IconButton( icon: Icon(Icons.edit,color: Color.fromARGB(255, 206, 134, 34),),
                                          onPressed: (){Navigator.pushNamed(context, '/editRestaurant',arguments: snapshot.data![index]);},),
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
                            return Text('Error loading data : ${snapshot.error}');
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

