import 'dart:math';

import 'package:demo/app.dart';
import 'package:demo/screen/splash.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setUserId(
      id: (Random().nextInt(90) + 10).toString()
    );
    return AppInheritedWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Ecommerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
