class Hotel {
   int? id;
   String name;
   String contacNumber;
   String address;
   int cityId;
   String image;
   int classStar;
   String? url;
   

   Hotel({this.id,required this.contacNumber,required this.name,
    required this.address,required this.cityId,
    required this.classStar,required this.image,this.url});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    final hotel= Hotel(
      id: json['id'],
      name: json['name'],
      contacNumber: json['contactNumber'],
      address: json['address'],
      cityId: json['cityId'],
      url: json['url'],
      classStar: json['classStar'],
      image: json['image'],

    );
    return hotel;
    
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactNumber': contacNumber,
      'address': address,
      'cityId': cityId,
      'url': url,
      'classStar': classStar,
      'image': image,


    };
  }

    

}