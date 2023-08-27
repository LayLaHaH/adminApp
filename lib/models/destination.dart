class Destination {
   int? id;
   String name;
   String description;
   String address;
   String theme;
   int cityId;
  List<Pictures> pictures;
   

   Destination({this.id,required this.description,required this.name,
    required this.address,required this.cityId,required this.theme,required this.pictures});

  factory Destination.fromJson(Map<String, dynamic> json) {
    
    return Destination(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      theme: json['theme'],
      cityId: json['cityId'],
      pictures: List<Pictures>.from(json['destinationPictures'].map((x) => Pictures.fromJson(x))),
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'theme': theme,
      'cityId': cityId,
    };
  }

    

}

class Pictures {
  int id;
  String picture;
  int destId;

  Pictures({required this.id, required this.picture, required this.destId});

   factory Pictures.fromJson(Map<String, dynamic> json) {
    return Pictures(
      id: json['id'],
      picture: json['picture'],
      destId: json['destId'],
    );
  }
}