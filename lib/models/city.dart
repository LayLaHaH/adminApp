import 'governorate.dart';

class City {
  final int? id;
  final String name;
  final String description;
  final String picture;
  final int? governorateId; // Make governorateId nullable
  final Governorate? governorate; 

  City({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    this.governorateId, // Update constructor to accept nullable value
    this.governorate, 
  });

factory City.fromJson(Map<String, dynamic> json) {
  final city = City(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    picture: json['picture'],
    governorateId: json['governerateId'],
    governorate: json['governorate'],
  );
  return city;
}

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'picture': picture,
      'governerateId': governorateId,
    };
  }

}