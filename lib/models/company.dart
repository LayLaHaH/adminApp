class Company {
   int? id;
   String name;
   String contactNumber;
   String address;
   

   Company({this.id,required this.contactNumber,
      required this.name,required this.address,});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      contactNumber: json['contactNumber'],
      address: json['address'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactNumber': contactNumber,
      'address': address,
    };
  }

}