// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_declarations, unused_import

import 'package:flutter/material.dart';
import 'package:my_flutter/CRUD/activities/activitySettings.dart';
import 'package:my_flutter/CRUD/activities/add_activity.dart';
import 'package:my_flutter/CRUD/activities/edit_activity.dart';
import 'package:my_flutter/CRUD/cities/add_city.dart';
import 'package:my_flutter/CRUD/cities/citySettings.dart';
import 'package:my_flutter/CRUD/cities/edit_city.dart';
import 'package:my_flutter/CRUD/companies/add_company.dart';
import 'package:my_flutter/CRUD/companies/companySettings.dart';
import 'package:my_flutter/CRUD/companies/edit_company.dart';
import 'package:my_flutter/CRUD/destinations/add_destination.dart';
import 'package:my_flutter/CRUD/destinations/destinationSettings.dart';
import 'package:my_flutter/CRUD/destinations/edit_destination.dart';
import 'package:my_flutter/CRUD/governorates/edit_governorate.dart';
import 'package:my_flutter/CRUD/governorates/govSettings.dart';
import 'package:my_flutter/CRUD/hotels/addHotel.dart';
import 'package:my_flutter/CRUD/hotels/edit_hotel.dart';
import 'package:my_flutter/CRUD/hotels/hotelSettings.dart';
import 'package:my_flutter/CRUD/markets/add_market.dart';
import 'package:my_flutter/CRUD/markets/edit_market.dart';
import 'package:my_flutter/CRUD/markets/marketSettings.dart';
import 'package:my_flutter/CRUD/restaurants/add_reataus.dart';
import 'package:my_flutter/CRUD/restaurants/edit_restaus.dart';
import 'package:my_flutter/CRUD/restaurants/restauSettings.dart';
import 'package:my_flutter/CRUD/tours/add_tour.dart';
import 'package:my_flutter/CRUD/tours/edit_tour.dart';
import 'package:my_flutter/CRUD/tours/tourSettings.dart';
import 'package:my_flutter/home.dart';
import 'package:my_flutter/login.dart';
import 'package:my_flutter/providers/token.dart';
import 'package:provider/provider.dart';

import 'CRUD/governorates/add_governorate.dart';


void main() => runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Token()),
    ],
    child:   MaterialApp(
        debugShowCheckedModeBanner: false,
  
        initialRoute:'/home',
  
        routes: {
  
          '/':(context) => Login(),
  
          '/home':(context) => Home(),


          '/govs':(context) => govSettings(),
  
          '/addGov':(context) => AddGovernorate(),
  
          '/editGov':(context) => EditGovernorate(),
  
  
  
          '/cities':(context) => CitySettings(),
  
          '/addCity':(context) => AddCity(),
  
          '/editCity':(context) => EditCity(),
  
  
  
          '/hotels':(context) => HotelSettings(),
  
          '/addHotel':(context) => AddHotel(),
  
          '/editHotel':(context) => EditHotel(),
  
  
  
          '/markets':(context) => MarketSettings(),
  
          '/addMarket':(context) => AddMarket(),
  
          '/editMarket':(context) => EditMarket(),
  
  
  
          '/restaurants':(context) => RestaurantSettings(),
  
          '/addRestaurant':(context) => AddRestaurant(),
  
          '/editRestaurant':(context) => EditRestaurant(),
  
  
  
          '/activities':(context) => ActivitySettings(),
  
          '/addActivity':(context) => AddActivity(),
  
          '/editActivity':(context) => EditActivity(),
  
  
  
          '/companies':(context) => CompanySettings(),
  
          '/addCompany':(context) => AddCompany(),
  
          '/editCompany':(context) => EditCompany(),
  
  
  
          '/tours':(context) => TourSettings(),
  
          '/addTour':(context) => AddTour(),
  
          '/editTour':(context) => EditTour(),
  
  
  
          '/destinations':(context) => DestinationSettings(),
  
          '/addDestination':(context) => AddDestination(),
  
          '/editDestination':(context) => EditDestination(),
  
        },
  
      ),
));
  
var baseUrl='http://192.168.94.178:45455/api';  
bool isVisible =false;
var token;


