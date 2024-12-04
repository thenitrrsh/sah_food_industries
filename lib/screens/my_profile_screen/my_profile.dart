import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/widgets/common_text_field.dart';

import '../../Constants.dart';
import '../../app/shared_preferences_helper.dart';
import '../../models/user_model.dart';
import 'my_profile_provider.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key});

  static ChangeNotifierProvider<MyProfileProvider> builder(
      BuildContext context) {
    return ChangeNotifierProvider<MyProfileProvider>(
        create: (context) => MyProfileProvider(),
        builder: (context, snapshot) {
          return MyProfileScreen();
        });
  }

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    MyProfileProvider myProfileProvider = MyProfileProvider();
    UserModel? userData = SharedPreferencesHelper.getUserData();
    myProfileProvider.nameController.text = userData!.name ?? '';
    myProfileProvider.emailController.text = userData.email ?? '';
    myProfileProvider.passwordController.text = userData.password ?? '';

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'My Profile',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonTextField(
                title: 'Name',
                keyboardType: TextInputType.text,
                hintText: 'Enter your full name',
                controller: myProfileProvider.nameController,
                isRequired: true,
                readonly: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonTextField(
                title: 'Email',
                keyboardType: TextInputType.text,
                hintText: 'Enter your email',
                controller: myProfileProvider.emailController,
                isRequired: true,
                readonly: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonTextField(
                title: 'Password',
                keyboardType: TextInputType.text,
                hintText: 'Enter your password',
                controller: myProfileProvider.passwordController,
                isRequired: true,
                readonly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
