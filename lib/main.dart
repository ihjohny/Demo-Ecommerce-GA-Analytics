import 'package:demo/app.dart';
import 'package:demo/screen/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
