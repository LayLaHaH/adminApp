import 'package:my_flutter/models/city.dart';

class Governorate {
   int? id;
   String name;
   String description;
   String picture;
   List<City>? cities;
   
   Governorate({this.id,required this.description,required this.name,required this.picture,this.cities});

   factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      picture: json['picture'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id=null,
      'name': name,
      'description': description,
      'picture': picture,
      'cities':cities=null,
    };
  }
  
  static Governorate toGovernorate(Map<String, dynamic> json) {
    List<City> citiesList = [];
    for (var city in json['cities']) {
      citiesList.add(City.fromJson(city));
    }

    return Governorate(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      picture: json['picture'],
      cities: citiesList,
    );
  }

}