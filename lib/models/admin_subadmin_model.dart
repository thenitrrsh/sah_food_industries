import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sah_food_industries/models/user_model.dart';

class AdminModel{
  List<UserModel>? data;
  String? error;
  DocumentSnapshot? lastDocument;
  bool? allDataLoaded;
}