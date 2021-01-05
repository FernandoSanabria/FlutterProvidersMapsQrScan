import 'package:flutter/material.dart';


class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leading;
  CustomListTile({this.title,this.subtitle,this.leading});  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: leading=='map' ? 
      Icon(Icons.map_outlined,color: Colors.blue,):
      Icon(Icons.house,color: Colors.blue,),
      trailing: IconButton(icon: Icon(Icons.arrow_forward_ios, size: 20.0), onPressed: () {
        
        var coordinateOne;
        var coordinateTwo;
        coordinateOne = title.split(',')[0];
        coordinateTwo = title.split(',')[1].trim();


        Navigator.pushNamed(context, 'map', arguments: {
          'coordinateOne': coordinateOne,
          'coordinateTwo': coordinateTwo
        });
      }),     
    );
  }
}