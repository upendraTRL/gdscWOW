import 'package:flutter/material.dart';
import 'package:testflutter/language_page.dart';
import 'package:testflutter/mongodb.dart';
import 'Services/notifi_service.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  Future.delayed(const Duration(seconds: 4), () {
    MongoDatabase.connect();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notifications',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Home Page',
      ),
    );
  }
}
