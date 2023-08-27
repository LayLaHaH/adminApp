class Tour {
  int? id;
  String name;
  String daysNnights;
  double cost;
  String theme;
  bool isPrivate;
  String guidLanguage;
  int companyId;
  List<Exclude> excludes;
  List<Include> includes;
  List<Itinerary> itineraries;
  List<TourHasActivity> tourHasActivities;
  List<TourHasDestination> tourHasDestinations;

  Tour({
    required this.id,
    required this.name,
    required this.daysNnights,
    required this.cost,
    required this.theme,
    required this.isPrivate,
    required this.guidLanguage,
    required this.companyId,
    required this.excludes,
    required this.includes,
    required this.itineraries,
    required this.tourHasActivities,
    required this.tourHasDestinations,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      name: json['name'],
      daysNnights: json['daysNnights'],
      cost: json['cost'],
      theme: json['theme'],
      isPrivate: json['isPrivate'],
      guidLanguage: json['guidLanguage'],
      companyId: json['companyId'],
      excludes: List<Exclude>.from(json['excludes'].map((x) => Exclude.fromJson(x))),
      includes: List<Include>.from(json['includes'].map((x) => Include.fromJson(x))),
      itineraries: List<Itinerary>.from(json['itineraries'].map((x) => Itinerary.fromJson(x))),
      tourHasActivities: List<TourHasActivity>.from(json['tourHasActivities'].map((x) => TourHasActivity.fromJson(x))),
      tourHasDestinations: List<TourHasDestination>.from(json['tourHasDestinations'].map((x) => TourHasDestination.fromJson(x))),
    );
  }
}

class Exclude {
  int id;
  String excludes;
  int tourId;

  Exclude({required this.id, required this.excludes, required this.tourId});

   factory Exclude.fromJson(Map<String, dynamic> json) {
    return Exclude(
      id: json['id'],
      excludes: json['excludes'],
      tourId: json['tourId'],
    );
  }
}

class Include {
  int id;
  String includes;
  int tourId;

  Include({required this.id, required this.includes, required this.tourId});

   factory Include.fromJson(Map<String, dynamic> json) {
    return Include(
      id: json['id'],
      includes: json['includes'],
      tourId: json['tourId'],
    );
  }
}

class Itinerary {
  int id;
  String eachDayDescription;
  int tourId;

  Itinerary({required this.id, required this.eachDayDescription, required this.tourId});

   factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      id: json['id'],
      eachDayDescription: json['eachDayDescription'],
      tourId: json['tourId'],
    );
  }
}

class TourHasActivity {
  int id;
  int tourId;
  int activityId;

  TourHasActivity({required this.id, required this.tourId, required this.activityId});

   factory TourHasActivity.fromJson(Map<String, dynamic> json) {
    return TourHasActivity(
      id: json['id'],
      tourId: json['tourId'],
      activityId: json['activityId'],
    );
  }
}

class TourHasDestination {
  int id;
  int destId;
  int tourId;

  TourHasDestination({required this.id, required this.destId, required this.tourId});

   factory TourHasDestination.fromJson(Map<String, dynamic> json) {
    return TourHasDestination(
      id: json['id'],
      destId: json['destId'],
      tourId: json['tourId'],
    );
  }
}