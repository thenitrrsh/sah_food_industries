import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sah_food_industries/enums/enums.dart';

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
  Future<bool> checkAdminExist(String email) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.subAdminCollection)
          .where('email', isEqualTo: email)
          .get();
      if (response.size > 0) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> checkUserExist(String phone) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.userCollection)
          .where('phone', isEqualTo: phone)
          .get();
      if (response.size > 0) {
        return true;
      }
      return false;
    } catch (e) {
      return null;
    }
  }

  Future<bool> createNewUser(String phone, String name, String password,
      String tvId, String email) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.userCollection)
          .doc()
          .set({
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

  Future<bool> updateUser(String phone, String name, String password,
      String tvId, String email, String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.userCollection)
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

  Future<bool> deleteUser(String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.userCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<UserModel>> getUserList() async {
    List<UserModel> userList = [];
    try {
      var response =
      await firestore.collection(FirebaseConstants.userCollection).get();
      if (response.size > 0) {
        for (var i in response.docs) {
          UserModel userModel = UserModel();
          userModel.name = i.data()['name'];
          userModel.email = i.data()['email'];
          userModel.phone = i.data()['phone'].toString();
          userModel.docId = i.id;
          userModel.password = i.data()['password'];
          userList.add(userModel);
        }
      }
      return userList;
    } catch (e) {
      return [];
    }
  }


  Future<bool> createNewAdmin(
      {required String phone, required String name, required String password,required String email, required AdminType type}) async {
    String adminType = 'sub-admin';
    if(type == AdminType.admin){
      adminType = 'admin';
    }
    try {
      var response = await firestore
          .collection(FirebaseConstants.subAdminCollection)
          .doc()
          .set({
        'name': name,
        'password': password,
        'phone': phone,
        'created_at': Timestamp.now(),
        'email': email,
        'type' : adminType
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAdmin(String phone, String name, String password, String email, String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.subAdminCollection)
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
          .collection(FirebaseConstants.userCollection)
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

      var firestoreQuery = firestore.collection(FirebaseConstants.subAdminCollection).where("");
      if(query != ""){
        firestoreQuery = firestoreQuery.where("name", isEqualTo: query);
      }

      firestoreQuery = firestoreQuery.limit(limit);

      firestoreQuery = firestoreQuery.orderBy('created_at', descending: true);
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
           await firestore.collection(FirebaseConstants.userCollection).where('created_by', isEqualTo: userModel.docId).count().get(source: AggregateSource.server);
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
