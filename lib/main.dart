import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wype_user/home/root.dart';
import 'package:wype_user/services/firebase_services.dart';
import 'auth/login_page.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wype',
  
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    route();
  }

  route() async {
    userData = await firebaseService.getUserDetails();
    if (userData == null) {
      Timer(Duration(seconds: 1), () {
        navigation(context, LoginPage(), true);
      });
    } else {
      navigation(context, RootPage(), true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SizedBox(
          height: height(context),
          width: width(context),
          child: Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.contain,
              width: width(context) * 0.5,
            ),
          ),
        ));
  }
}
