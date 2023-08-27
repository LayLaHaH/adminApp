//import 'dart:convert';
// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter/models/activity.dart';
import 'package:my_flutter/models/company.dart';
import 'package:my_flutter/models/destination.dart';

import '../../main.dart';
import '../../widgets/my_text_filed.dart';
import '../../widgets/multi_text_insert.dart';
import '../../widgets/multi_select_list.dart';


class AddTour extends StatefulWidget {
  const AddTour({super.key});

  @override
  _AddTourState createState() => _AddTourState();
}

class _AddTourState extends State<AddTour> {
  bool isPrivate = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _daysController = TextEditingController();
  final _costController = TextEditingController();
  final _themeController = TextEditingController();
  final _guidController = TextEditingController();
  late var _companyController;
  List<TextEditingController> includesControllers = [TextEditingController()];
  List<TextEditingController> excludesControllers = [TextEditingController()];
  List<TextEditingController> itinerariesControllers = [TextEditingController()];
  List<Destination> _SelectedDestinations = [];
  List<Activity> _SelectedActivities = [];
  late var _selectedCompany ;


  Future<List<Activity>> getActivities() async {
    // Make a get request to the records from the API
    final response = await http.get(Uri.parse('$baseUrl/Activity/getAll'));
    var responseData = json.decode(response.body);

    List<Activity> activities = [];
    for (var act in responseData) {
      Activity activity = Activity.fromJson(act);
      activities.add(activity);
    }
    return activities;
  }

  Future<List<Destination>> getDestinations() async {
    // Make a get request to the records from the API
    final response = await http.get(Uri.parse('$baseUrl/Destination/getAll2'));
    var responseData = json.decode(response.body);

    List<Destination> destinations = [];
    for (var dest in responseData) {
      Destination destination = Destination.fromJson(dest);
      destinations.add(destination);
    }
    return destinations;
  }

  Future<List<Company>> getCompanies() async {
    // Make a get request to the records from the API
    final response = await http.get(Uri.parse('$baseUrl/TourCompany/getAll'));
    var responseData = json.decode(response.body);

    List<Company> companies = [];
    for (var comp in responseData) {
      Company company = Company.fromJson(comp);
      companies.add(company);
    }
    return companies;
  }

  void _showDestinations() async {
    final List<Destination>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(itemsFuture: getDestinations(),
                  getName: (destination) => destination.name);
      },
    );
    // Update UI
    if (results != null) {
      setState(() {_SelectedDestinations = results;});
    }
  }

  void _showActivities() async {
   final List<Activity>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(itemsFuture: getActivities(),
                  getName: (activity) => activity.name);
      },
    );
    // Update UI
    if (results != null) {
      setState(() { _SelectedActivities = results;});
    }
  }

 Future<void> _submit1() async{
  if (_formKey.currentState!.validate()){
    //preparing the lists for the body
    List<String> _includes = [];
    for (var controller in includesControllers) {
      _includes.add(controller.text); }
    List<String> _excludes = [];
    for (var controller in excludesControllers) {
      _excludes.add(controller.text);}
    List<String> _itineraries = [];
    for (var controller in itinerariesControllers) {
      _itineraries.add(controller.text);} 
    List<String> _destinations = [];
    for (var dest in _SelectedDestinations) {
      _destinations.add(dest.id.toString());}
    List<String> _activities = [];
    for (var act in _SelectedActivities) {
      _activities.add(act.id.toString());}

    //sending the post request
    final url = '$baseUrl/Tour/create';
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'Name': _nameController.text,
      'DaysNnights': _daysController.text,
      'Cost': _costController.text,
      'IsPrivate': isPrivate.toString(),
      'Theme': _themeController.text,
      'GuidLanguage': _guidController.text,
      'CompanyId': _companyController,
      for (int i = 0; i < _destinations.length; i++) 
        'SelectedDestinations[$i]': _destinations[i],
      for (int i = 0; i < _activities.length; i++) 
        'SelectedActivities[$i]': _activities[i],
      for (int i = 0; i < _includes.length; i++) 
        'InsertedIncludes[$i]': _includes[i],
      for (int i = 0; i < _excludes.length; i++) 
        'InsertedExcludes[$i]': _excludes[i],
      for (int i = 0; i < _itineraries.length; i++) 
        'InsertedItineraries[$i]': _itineraries[i],
    };
    
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('Tour created successfully');
      Navigator.pushNamed(context,'/tours');
    } else {
      debugPrint('Error creating tour: ${response.reasonPhrase}');
    }
  }
}

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Tour'),
        backgroundColor: Colors.pink[800],
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children:[ Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //name field
                    MyTextField(nameController: _nameController, 
                       erreMessage: "please enter a name", label: "Name",),
                    //number of days and nights field
                    TextFormField(
                      controller: _daysController,
                      decoration: InputDecoration(
                        labelText: 'Days and Nights',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the number of days and nights';
                        }
                        return null;
                      },
                    ),
                    //cost field
                    TextFormField(
                      controller: _costController,
                      decoration: InputDecoration(
                        labelText: 'Cost',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the cost';
                        }
                        return null;
                      },
                    ),
                    //theme filed 
                    TextFormField(
                      controller: _themeController,
                      decoration: InputDecoration(
                        labelText: 'Theme',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a theme';
                        }
                        return null;
                      },
                    ),
                    //is private checkbox
                    SwitchListTile(
                      title: Text('Private'),
                      value: isPrivate,
                      onChanged: (bool value) {
                        setState(() {
                          isPrivate = value;
                        });
                      },
                    ),
                    //guid language field
                    TextFormField(
                      controller: _guidController,
                      decoration: InputDecoration(
                        labelText: 'Guid Language',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a guid language';
                        }
                        return null;
                      },
                    ),
                    //includes fields
                    MultiTextField(Controllers: includesControllers, label: "Includes"),
                    //excludes fields
                    MultiTextField(Controllers: excludesControllers, label: "Excludes"),
                    //itineraries fields
                    MultiTextField(Controllers: itinerariesControllers, label: "Itineraries"),
                    SizedBox(height: 16,),
                    //select the destinations
                    ElevatedButton(
                      onPressed: _showDestinations,
                      child: const Text('Select deastinations'),
                    ),
                    const Divider( height: 30,),
                    // display selected Destinations
                    Wrap(
                      children: _SelectedDestinations
                          .map((e) => Chip(
                                label: Text(e.name),
                              ))
                          .toList(),
                    ),
                    //select the activities
                    ElevatedButton(
                      onPressed: _showActivities,
                      child: const Text('Select activities'),
                    ),
                    const Divider(height: 30,),
                    //display selected activities
                    Wrap(
                      children: _SelectedActivities
                          .map((e) => Chip(
                                label: Text(e.name),
                              ))
                          .toList(),
                    ),
                    //company list
                    FutureBuilder(
                      future:getCompanies() ,
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
                        
                        if (snapshot.data == null) {
                          return
                          TextButton(onPressed: () {  },
                          child: const Text("loading.."),
        
                          );
                        }
                        else{
                        _selectedCompany=snapshot.data[0];
                        
                      return DropdownButtonFormField<Company>(
                        
                        items: snapshot.data!.map((comp) => DropdownMenuItem<Company>(value: comp as Company, child: Text(comp.name))).toList().cast<DropdownMenuItem<Company>>(),
                        decoration: InputDecoration(labelText: 'Governorate'),
                        onChanged: (value) {
                          setState(() {
                            _selectedCompany = value;
                            _companyController=_selectedCompany.id.toString();
                            /////print(_selectedCompany.id);
                          });
                        },
                        value: _selectedCompany,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a Governorate';
                          }
                          return null;
                        },
                      );
                        }
                      },
                    ),
                    //submit button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _submit1();
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

