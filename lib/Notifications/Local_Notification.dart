import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class Local_Notification extends StatefulWidget {
  @override
  State<Local_Notification> createState() => _Local_NotificationState();
}

class _Local_NotificationState extends State<Local_Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Save"),
          onPressed: (){
            AwesomeNotifications().createNotification(
                content: NotificationContent(
                    id: 10,
                    channelKey: 'basic_channel',
                    title: 'Simple Notification',
                    body: 'Simple body'
                )
            );
          },
        ),
      ),
    );
  }
}
