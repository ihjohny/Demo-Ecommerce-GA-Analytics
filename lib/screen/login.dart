import 'package:demo/screen/home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logScreenView(screenName: "Login Screen");
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "E-Commerce",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, height: 1.15),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: const FlutterLogo(
                  size: 60,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                height: 90,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    if (emailController.text.isNotEmpty) {
                      FirebaseAnalytics.instance.logLogin(loginMethod: "email");
                      FirebaseAnalytics.instance.setUserProperty(
                        name: 'user_email',
                        value: emailController.text,
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAnalytics.instance.logLogin(loginMethod: "guest");
                  FirebaseAnalytics.instance.setUserProperty(
                    name: 'user_email',
                    value: 'guest',
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'Guest User',
                  style: TextStyle(color: Colors.grey[600], fontSize: 18),
                ),
              ),
            ],
          ),
        ));
  }
}
