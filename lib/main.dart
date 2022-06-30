import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'FireBase/Firebase_HomePage.dart';
import 'Notifications/Cloud_Notification.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // AwesomeNotifications().initialize(
  //     'resource://drawable/logo',
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'basic_tests',
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white,
  //           importance: NotificationImportance.High,
  //       ),
  //
  //     ],
  //     channelGroups: [
  //       NotificationChannelGroup(channelGroupkey: 'basic_tests', channelGroupName: 'Basic tests'),
  //     ],
  //     debug: true
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireBase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Firebase_HomePage(),
    );
  }
}
