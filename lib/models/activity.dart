class Activity {
   int? id;
   String name;
   String description;
   String image;
   double price;
   DateTime startTime;
   DateTime closeTime;
   DateTime? startingDay;
   DateTime? endingDay;
   

   Activity({this.id,required this.description,required this.name,
   required this.image,required this.price,required this.startTime,
   required this.closeTime,this.endingDay,this.startingDay});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      startTime: DateTime.parse(json['startTime']),
    closeTime: DateTime.parse(json['closeTime']),
      startingDay: DateTime.parse(json['startingDay']),
      endingDay: DateTime.parse(json['endingDay']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'startTime': startTime,
      'closeTime': closeTime,
      'startingDay': startingDay,
      'endingDay': endingDay,
    };
  }

}