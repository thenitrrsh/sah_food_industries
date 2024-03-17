import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sah_food_industries/enums/enums.dart';
import '../models/admin_subadmin_model.dart';
import '../models/user_model.dart';
import '../services/firebase_services.dart';
import '../utils/toast_helper.dart';

class AdminSubAdminProvider extends ChangeNotifier {
  final FirebaseServices _firebaseServices = FirebaseServices();

  AdminModel? adminData;
  List<UserModel> _allAdminList = [];

  Timer? timer;
  DocumentSnapshot? lastDocument;
  int limit = 10;
  bool loading = false;
  bool paginationLoading = false;
  bool allDataLoaded = false;



  Future<bool> createAdmin(String phone, String password, String name, String email) async {
    bool? response = await _firebaseServices.checkUserExist(phone);
    if (response == null) {
      ToastHelper.showToast("Something went wrong");
      return false;
    }
    if (response == true) {
      ToastHelper.showToast("User with provided phone already exist");
      return false;
    }

    bool userResponse = await _firebaseServices.createNewAdmin(
      email: email,
      type: AdminType.subAdmin,
      password: password,
      phone: phone,
      name: name
    );
    if (userResponse) {
      ToastHelper.showToast("Created Successfully");
      return true;
    }

    return false;
  }

  Future<bool> updateAdmin(String phone, String password, String name,
      String tvId, String email, String docId) async {
    bool userResponse = await _firebaseServices.updateAdmin(
        phone, name, password, email, docId);
    if (userResponse) {
      ToastHelper.showToast("Updated Successfully");
      return true;
    }

    return false;
  }

  Future<bool> deleteAdmin(String docId) async {
    bool userResponse = await _firebaseServices.deleteAdmin(docId);
    if (userResponse) {
      ToastHelper.showToast("User Deleted Successfully");
      return true;
    }

    return false;
  }

  Future<void> getAdminList({String query = '', bool isReset = false}) async {
    if(isReset){
      loading = true;
      lastDocument = null;
      _allAdminList.clear();
      adminData = null;
      allDataLoaded = false;
    }else{
      paginationLoading = true;
    }
    if(allDataLoaded){
      paginationLoading = false;
      return;
    }
    notifyListeners();
   try{
     adminData = await _firebaseServices.getAdminList(query, lastDocument, limit);
     allDataLoaded = adminData?.allDataLoaded ?? false;
     loading = false;
     paginationLoading = false;
     lastDocument = adminData?.lastDocument;
     _allAdminList.addAll(adminData?.data ?? []);
     adminData?.data = _allAdminList;

     notifyListeners();
   }catch(e){
     notifyListeners();

   }
  }

  searchData(String query){
    adminData = null;
    notifyListeners();
   timer?.cancel();
   timer = Timer(const Duration(seconds: 1), () {
     getAdminList(query: query, isReset: true);
   });


    // if(query.trim() != ""){
    //   adminData?.data = _allAdminList.where((element) => element.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
    // }else{
    //   adminData?.data = _allAdminList;
    // }

    // notifyListeners();


  }



}
