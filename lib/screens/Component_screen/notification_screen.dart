import 'package:flutter/material.dart';
import 'package:rive_animation/component/NotificationWidget.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white10,
        title: Center(child: Padding(child: Text("Notification"), padding: EdgeInsets.fromLTRB(30, 0, 0, 0),)),
        actions: [Icon(Icons.search), SizedBox(width: 20,)],
        bottom: PreferredSize(
            child: Container(
              color: Colors.black12,
              height: 1,
            ),
            preferredSize: Size.fromHeight(0)),
      ),

      body: Column(
        children: [
          Notificationwidget(icon: Icon(Icons.account_circle, size: 35,), time: "12:01 - 30/03/2025", title: "Hello", description: "Toi nho em nhieu lam em co biet khong ha", background_color: Colors.white70,),
          Notificationwidget(icon: Icon(Icons.account_circle, size: 35,), time: "12:01 - 30/03/2025", title: "Hello", description: "Toi nho em nhieu lam em co biet khong ha", background_color: Color.fromRGBO(0, 255, 0, 0.3),)
        ],
      )
    );
  }
}
