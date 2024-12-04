import 'package:flutter/material.dart';

class MyProfileProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
}
