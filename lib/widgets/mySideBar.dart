// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class MySideBar extends StatelessWidget {
  const MySideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Color.fromARGB(255, 245, 234, 240),
      child: ListView(
              children: [
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Governorates'),
                         onTap: (){Navigator.pushNamed(context, '/govs');},),
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Cities'),
                         onTap: (){Navigator.pushNamed(context, '/cities');},),
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Markets'),
                         onTap: (){Navigator.pushNamed(context, '/markets');},),
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Hotles'),
                         onTap: (){Navigator.pushNamed(context, '/hotels');},),
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Restaurants'),
                         onTap: (){Navigator.pushNamed(context, '/restaurants');},),                                    
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Destinations'),
                         onTap: (){Navigator.pushNamed(context, '/destinations');},),
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Companies'),
                         onTap: (){Navigator.pushNamed(context, '/companies');},),
                
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Activities'),
                         onTap: (){Navigator.pushNamed(context, '/activities');},),
                ListTile(leading: Icon(Icons.settings_applications_sharp),
                         title: Text('Tours'),
                         onTap: (){Navigator.pushNamed(context, '/tours');},),
                
                Divider(), 
                
              ],
            ),
    );
  }
}