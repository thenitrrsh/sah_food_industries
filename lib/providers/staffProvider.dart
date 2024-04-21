
import 'package:flutter/material.dart';
import 'package:sah_food_industries/models/user_model.dart';
import 'package:sah_food_industries/services/firebase_services.dart';

enum StaffStatus { active, all }
class StaffProvider extends ChangeNotifier{

  StaffProvider(){
    getStaff();
  }

  final FirebaseServices _firebaseServices = FirebaseServices();

  List<UserModel>? staffList ;
  List<UserModel>? staffListSearch ;
  TextEditingController searchController = TextEditingController();
  StaffStatus status = StaffStatus.all;

  getStaff() async {
    List<UserModel> data = await _firebaseServices.getStaffList();
    staffList = data;
    staffListSearch = data;
    notifyListeners();
  }

  searchData(){
    if(searchController.text.isEmpty){
      staffListSearch = staffList;

    }else {
      staffListSearch = staffList!.where((element) => element.name!.toLowerCase().contains(searchController.text.trim().toLowerCase())).toList();
    }
    if(status == StaffStatus.active){

      staffListSearch = staffListSearch!.where((element) => element.status == 'online').toList();
    }
    notifyListeners();
  }

  changeStatus( StaffStatus newStatus) async {
    status = newStatus;
    searchController.clear();
    searchData();
  }



}