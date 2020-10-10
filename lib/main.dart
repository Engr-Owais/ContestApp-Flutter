import 'package:contest_app/Screens/Admin_HOme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

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
      home: SplashScreen(
            seconds: 4,
            navigateAfterSeconds: AdminHome(),
            title: new Text('Welcome To Contestor',
                style: GoogleFonts.abel(
                    fontWeight: FontWeight.bold, fontSize: 20)),
            image: new Image(
              image: AssetImage("assets/buffersplash.png"),
            ),
            backgroundColor: Colors.amber,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100,
            loaderColor: Colors.red));
  }
}
