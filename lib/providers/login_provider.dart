import 'package:firebase_auth/firebase_auth.dart';
import 'package:sah_food_industries/app/shared_preferences_helper.dart';
import 'package:sah_food_industries/models/user_model.dart';

import '../services/firebase_services.dart';
import '../utils/toast_helper.dart';

class LoginProvider {
  final FirebaseServices _firebaseServices = FirebaseServices();

  Future<bool> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.email != null) {
        UserModel? isAdminExist =
            await _firebaseServices.checkAdminExist(email);
        if (isAdminExist == null) {
          ToastHelper.showToast("No user found for this email.");
        }
        SharedPreferencesHelper.setUserData(isAdminExist!);

        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print("23 working ${e.toString()}");
      // if (e.code == 'user-not-found') {
      //   ToastHelper.showToast("No user found for that email.");
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      //   ToastHelper.showToast('Wrong password provided for that user.');
      // }
      ToastHelper.showToast('Invalid Credentials');

      return false;
    }
  }
}
