import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sah_food_industries/app/shared_preferences_helper.dart';
import 'package:sah_food_industries/enums/enums.dart';
import 'package:sah_food_industries/models/region_model.dart';
import 'package:sah_food_industries/models/state_model.dart';

import '../constants/firebase_constants.dart';

import '../models/admin_subadmin_model.dart';
import '../models/user_model.dart';

class FirebaseServices {
  static final FirebaseServices _singleton = FirebaseServices._internal();

  factory FirebaseServices() {
    return _singleton;
  }

  FirebaseServices._internal();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///user
  Future<UserModel?> checkAdminExist(String email) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.adminCollection)
          .where('email', isEqualTo: email)
          .get();

      if (response.size > 0) {
        UserModel userModel = UserModel();

        userModel.name = response.docs.first.data()['name'];
        userModel.email = response.docs.first.data()['email'];
        userModel.phone = response.docs.first.data()['phone'].toString();
        userModel.docId = response.docs.first.id;
        userModel.password = response.docs.first.data()['password'];
        userModel.regionId = response.docs.first.data()['region_id'];
        userModel.regionName = response.docs.first.data()['region_name'];
        userModel.stateId = response.docs.first.data()['state_id'];
        userModel.stateName = response.docs.first.data()['state_name'];
        userModel.type = response.docs.first.data()['type'];

        return userModel;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> checkUserExist(String email, String type) async {
    String userCollection = FirebaseConstants.adminCollection;
    if(type == 'staff'){
      userCollection = FirebaseConstants.staffCollection;

    }
    try {
      var response = await firestore
          .collection(userCollection)
          .where('email', isEqualTo: email)
          .get();
      if (response.size > 0) {
        return true;
      }
      return false;
    } catch (e) {
      return null;
    }
  }



  Future<bool?> handleSignUp(String email, String password) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    //10
    try{

      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //11
      return true;
    }catch(e){
      return null;
    }
  }



  Future<bool> updateStaff(String phone, String name, String password,
      String tvId, String email, String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.staffCollection)
          .doc(docId)
          .update({
        'name': name,
        'password': password,
        'phone': phone,
        'created_at': Timestamp.now(),
        'email': email,
        'tv_id_final': tvId
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteStaff(String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.staffCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<UserModel>> getStaffList() async {
    List<UserModel> userList = [];
    try {
      var response =
      await firestore.collection(FirebaseConstants.staffCollection).get();
      if (response.size > 0) {
        for (var i in response.docs) {
          UserModel userModel = UserModel();
          userModel.name = i.data()['name'];
          userModel.email = i.data()['email'];
          userModel.phone = i.data()['phone'].toString();
          userModel.docId = i.id;
          userModel.password = i.data()['password'];
          userModel.status = i.data()['status'];
          userList.add(userModel);
        }
      }
      return userList;
    } catch (e) {
      return [];
    }
  }


  Future<bool> createNewAdmin(
      {required String phone, required String name, required String password,required String email, required AdminType type, required String regionId, required String stateId,required String regionName, required String stateName}) async {
    String adminType = 'sub-admin';
    if(type == AdminType.admin){
      adminType = 'admin';
    }
    try {

      bool? userCreateResponse = await handleSignUp(email, password);
      if(userCreateResponse == null || userCreateResponse == false){
        return false;
      }
      var response = await firestore
          .collection(FirebaseConstants.adminCollection)
          .doc()
          .set({
        'name': name,
        'password': password,
        'phone': phone,
        'created_at': Timestamp.now(),
        'email': email,
        'type' : adminType,
        'region_id': regionId,
        'region_name': regionName,
        'state_name': stateName,
        'state_id': stateId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAdmin(String phone, String name, String password, String email, String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.adminCollection)
          .doc(docId)
          .update({
        'name': name,
        'password': password,
        'phone': phone,
        'created_at': Timestamp.now(),
        'email': email,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAdmin(String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.staffCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }


  Future<AdminModel> getAdminList(String query, DocumentSnapshot? lastDoc, int limit) async {
    List<UserModel> userList = [];
    AdminModel finalResponse = AdminModel();
    if(limit == 0){
      limit = 10;
    }
    try {

      var firestoreQuery = firestore.collection(FirebaseConstants.adminCollection).where("");
      if(query != ""){
        firestoreQuery = firestoreQuery.where("name", isEqualTo: query);
      }

      firestoreQuery = firestoreQuery.limit(limit);

      firestoreQuery = firestoreQuery.orderBy('created_at', descending: true);
      firestoreQuery = firestoreQuery.where('type', isEqualTo: 'sub-admin');
      if(lastDoc != null){
        firestoreQuery = firestoreQuery.startAfterDocument(lastDoc!);

      }

      var response= await firestoreQuery.get();


      if (response.size > 0) {
        finalResponse.lastDocument = response.docs.last;
        for (var i in response.docs) {
          UserModel userModel = UserModel();
          userModel.name = i.data()['name'];
          userModel.email = i.data()['email'];
          userModel.phone = i.data()['phone'].toString();
          userModel.docId = i.id;
          userModel.password = i.data()['password'];


          AggregateQuerySnapshot aggregateQuerySnapshot =
           await firestore.collection(FirebaseConstants.staffCollection).where('created_by', isEqualTo: userModel.docId).count().get(source: AggregateSource.server);
          userModel.totalStaff = aggregateQuerySnapshot.count ?? 0;

          userList.add(userModel);
        }
      }else{
        finalResponse.allDataLoaded = true;
      }
      finalResponse.data = userList;

    } catch (e) {
      finalResponse.allDataLoaded = true;
      finalResponse.error = "Something went wrong";
      throw Exception(e);
    }

    return finalResponse;
  }

  Future<bool> createStaff({required String name, required String phone, required String email, required String password}) async{
    UserModel? userModel = SharedPreferencesHelper.getUserData();
    try{
      bool? isUserExist = await checkUserExist(email, 'staff');
      if(isUserExist == true){
        return false;
      }

      bool? userCreateResponse = await handleSignUp(email, password);
      if(userCreateResponse == null || userCreateResponse == false){
        return false;
      }
      var response = await firestore.collection(FirebaseConstants.staffCollection).doc().set({
        'phone': phone,
        'name': name,
        'email': email,
        'password': password,
        'created_at': Timestamp.now(),
        'created_by': userModel!.docId,
        'region_id': userModel.regionId,
        'region_name': userModel.regionName,
        'state_id': userModel.stateId,
        'state_name': userModel.stateName,
        'status': 'offline'
      });
      return true;
    }catch(e){
      return false;
    }
  }



  // Future<CountryListModel> getCountries() async {
  //
  //   try {
  //     var response = await firestore.collection(FirebaseConstants.countryCollection).get();
  //     print("response.docs ${response.docs.length}");
  //     return CountryListModel.fromMap(response.docs);
  //   } catch (e) {
  //     return CountryListModel.error("Something went wrong");
  //     throw Exception(e);
  //   }
  // }
  //
  Future<RegionListModel> getRegions({String? stateId}) async {
    List<RegionModel> regionList = [];
    try {
      var response ;
      if(stateId != null){
        response = await firestore.collection(FirebaseConstants.regionCollection).where('state_id', isEqualTo: stateId).get();}
      else{
        response = await firestore.collection(FirebaseConstants.regionCollection).get();
      }
      if (response.size > 0) {
        var data= RegionListModel.fromMap(response.docs);
        return data;
      }
      return RegionListModel(regionList: regionList);
    } catch (e) {
      return RegionListModel.error("Something went wrong");
      throw Exception(e);
    }
  }



  Future<String?> createRegion(String regionName, String stateId, String stateName) async {
    try {
      var existingRegion = await firestore.collection(FirebaseConstants.regionCollection).where('name', isEqualTo: regionName).where('state_id', isEqualTo:  stateId).get();
      if(existingRegion.size > 0){
        return "Region already exist";
      }
      var response = await firestore
          .collection(FirebaseConstants.regionCollection)
          .doc()
          .set({
        'name': regionName,
        'state_id': stateId,
        'state_name': stateName,
        'created_at': Timestamp.now(),
      });
      return null;
    } catch (e) {
      return "Something went wrong";
    }
  }



  Future<bool> deleteRegion(String docId) async {
    try {
      await firestore.collection(FirebaseConstants.regionCollection).doc(docId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<StateListModel> getStates() async {
    try {
      var response = await firestore.collection(FirebaseConstants.stateCollection).get();
      if (response.size > 0) {
        var data= StateListModel.fromMap(response.docs);
        return data;
      }
      return StateListModel(regionList: []);
    } catch (e) {
      return StateListModel.error("Something went wrong");
      throw Exception(e);
    }
  }





////deleteAds
//   Future<bool> deleteAd(String doc) async {
//     try {
//       var response = await firestore
//           .collection(FirebaseConstants.adsCollection)
//           .doc(doc)
//           .delete();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

  ///deleteCompany
  // Future<bool> deleteCompany(String doc) async {
  //   try {
  //     var response = await firestore
  //         .collection(FirebaseConstants.companyCollection)
  //         .doc(doc)
  //         .delete();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  ////companyCreate
  // Future<bool> createCompany(
  //     String companyName, String companyGST, String companyNumber, String companyEmail) async {
  //   try {
  //     var response = await firestore
  //         .collection(FirebaseConstants.companyCollection)
  //         .doc(companyEmail)
  //         .set({
  //       'company_name': companyName,
  //       'company_gst': companyGST,
  //       'company_contact_number': companyNumber,
  //       'date': Timestamp.now(),
  //       'company_id': companyEmail
  //     }, SetOptions(merge: true));
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }


  ////Company
  // Future<List<CompanyModel>> getCompanyList() async {
  //   List<CompanyModel> companyList = [];
  //   try {
  //     var response =
  //     await firestore.collection(FirebaseConstants.companyCollection).get();
  //     if (response.size > 0) {
  //       for (var i in response.docs) {
  //         CompanyModel companyModel = CompanyModel();
  //         companyModel.companyName = i.data()['company_name'];
  //         companyModel.companyGST = i.data()['company_gst'];
  //         companyModel.companyNumber = i.data()['company_contact_number'];
  //         companyModel.docId = i.id;
  //         companyList.add(companyModel);
  //       }
  //     }
  //
  //     return companyList;
  //   } catch (e) {
  //     return [];
  //   }
  // }


  String getFormatedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
