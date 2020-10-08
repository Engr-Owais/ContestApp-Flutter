import 'package:contest_app/Screens/Admin_HOme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contest Admin',
      defaultTransition: Transition.zoom,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: AdminHome(),
    );
  }
}
