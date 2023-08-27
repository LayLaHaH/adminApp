class Restaurant {
   int? id;
   String name;
   String contacNumber;
   String address;
   String cuisine;
   int cityId;
   String image;
   DateTime closingHour;
   DateTime openingHour;
   int classStar;
   String? url;
   

   Restaurant({this.id,required this.contacNumber,required this.name,
    required this.address,required this.cityId,required this.cuisine,
    required this.openingHour,required this.closingHour,
    required this.classStar,required this.image,this.url});

    factory Restaurant.fromJson(Map<String, dynamic> json) {
      return Restaurant(
        id: json['id'],
        name: json['name'],
        contacNumber: json['contactNumber'],
        address: json['address'],
        cuisine: json['cuisine'],
        cityId: json['cityId'],
        openingHour: DateTime.parse(json['openingHour']),
        closingHour: DateTime.parse(json['closingHour']),
        url: json['url'],
        classStar: json['classStar'],
        image: json['image'],
      );
    }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactNumber': contacNumber,
      'address': address,
      'cuisine': cuisine,
      'cityId': cityId,
      'url': url,
      'openingHour': openingHour,
      'closingHour': closingHour,
      'classStar': classStar,
      'image': image,


    };
  }

    

}