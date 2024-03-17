import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_services.dart';
import '../utils/toast_helper.dart';

class LoginProvider {
  final FirebaseServices _firebaseServices = FirebaseServices();

  Future<bool> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.email != null) {
        bool isAdminExist = await _firebaseServices.checkAdminExist(email);
        if (!isAdminExist) {
          ToastHelper.showToast("No user found for that email.");
        }
        return isAdminExist;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print("23 working ${e.stackTrace}");
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
