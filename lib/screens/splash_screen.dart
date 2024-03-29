import 'package:flutter/material.dart';
import 'package:sah_food_industries/app/shared_preferences_helper.dart';
import 'package:sah_food_industries/screens/dashboard/home_screen.dart';

import 'login_register_screen.dart/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    Future.delayed(
        const Duration(seconds: 2),
        (){
          if(SharedPreferencesHelper.isLogin()){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }else{
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 300,
                width: 550,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Hero(
                      tag: 'preview',
                      child: Image.asset("assets/images/logo_sfi.png")),
                ),
              ),
            ),
          ]),
    );
  }
}
