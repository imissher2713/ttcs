import 'package:flutter/material.dart';

class Notificationwidget extends StatelessWidget {
  Icon? icon;
  String title, description, time;
  Color background_color;


  Notificationwidget({this.icon, required this.time, required this.title, required this.description, required this.background_color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.icon,
      tileColor: background_color,
      title: Text(this.time),
      subtitle: Text(description, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );

  }
}
