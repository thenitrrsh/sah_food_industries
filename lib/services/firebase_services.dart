import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sah_food_industries/app/shared_preferences_helper.dart';
import 'package:sah_food_industries/enums/enums.dart';
import 'package:sah_food_industries/models/product_category_model.dart';
import 'package:sah_food_industries/models/product_model.dart';
import 'package:sah_food_industries/models/region_model.dart';
import 'package:sah_food_industries/models/state_model.dart';

import '../constants/firebase_constants.dart';

import '../models/admin_subadmin_model.dart';
import '../models/notes_list_model.dart';
import '../models/user_model.dart';
import '../screens/dealers/get_dealer_list_model.dart';

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
    if (type == 'staff') {
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
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //11
      return true;
    } catch (e) {
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
      {required String phone,
      required String name,
      required String password,
      required String email,
      required AdminType type,
      required String regionId,
      required String stateId,
      required String regionName,
      required String stateName}) async {
    String adminType = 'sub-admin';
    if (type == AdminType.admin) {
      adminType = 'admin';
    }
    try {
      bool? userCreateResponse = await handleSignUp(email, password);
      if (userCreateResponse == null || userCreateResponse == false) {
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
        'type': adminType,
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

  Future<bool> updateAdmin(String phone, String name, String password,
      String email, String docId) async {
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

  Future<AdminModel> getAdminList(
      String query, DocumentSnapshot? lastDoc, int limit) async {
    List<UserModel> userList = [];
    AdminModel finalResponse = AdminModel();
    if (limit == 0) {
      limit = 10;
    }
    try {
      var firestoreQuery =
          firestore.collection(FirebaseConstants.adminCollection).where("");
      if (query != "") {
        firestoreQuery = firestoreQuery.where("name", isEqualTo: query);
      }

      firestoreQuery = firestoreQuery.limit(limit);

      firestoreQuery = firestoreQuery.orderBy('created_at', descending: true);
      firestoreQuery = firestoreQuery.where('type', isEqualTo: 'sub-admin');
      if (lastDoc != null) {
        firestoreQuery = firestoreQuery.startAfterDocument(lastDoc!);
      }

      var response = await firestoreQuery.get();

      if (response.size > 0) {
        finalResponse.lastDocument = response.docs.last;
        for (var i in response.docs) {
          UserModel userModel = UserModel();
          userModel.name = i.data()['name'];
          userModel.email = i.data()['email'];
          userModel.phone = i.data()['phone'].toString();
          userModel.docId = i.id;
          userModel.password = i.data()['password'];

          AggregateQuerySnapshot aggregateQuerySnapshot = await firestore
              .collection(FirebaseConstants.staffCollection)
              .where('created_by', isEqualTo: userModel.docId)
              .count()
              .get(source: AggregateSource.server);
          userModel.totalStaff = aggregateQuerySnapshot.count ?? 0;

          userList.add(userModel);
        }
      } else {
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

  Future<bool> createStaff(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    UserModel? userModel = SharedPreferencesHelper.getUserData();
    try {
      bool? isUserExist = await checkUserExist(email, 'staff');
      if (isUserExist == true) {
        return false;
      }

      bool? userCreateResponse = await handleSignUp(email, password);
      if (userCreateResponse == null || userCreateResponse == false) {
        return false;
      }
      var response = await firestore
          .collection(FirebaseConstants.staffCollection)
          .doc()
          .set({
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
    } catch (e) {
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
      var response;
      if (stateId != null) {
        response = await firestore
            .collection(FirebaseConstants.regionCollection)
            .where('state_id', isEqualTo: stateId)
            .get();
      } else {
        response = await firestore
            .collection(FirebaseConstants.regionCollection)
            .get();
      }
      if (response.size > 0) {
        var data = RegionListModel.fromMap(response.docs);
        return data;
      }
      return RegionListModel(regionList: regionList);
    } catch (e) {
      return RegionListModel.error("Something went wrong");
      throw Exception(e);
    }
  }

  Future<String?> createRegion(
      String regionName, String stateId, String stateName) async {
    try {
      var existingRegion = await firestore
          .collection(FirebaseConstants.regionCollection)
          .where('name', isEqualTo: regionName)
          .where('state_id', isEqualTo: stateId)
          .get();
      if (existingRegion.size > 0) {
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
      await firestore
          .collection(FirebaseConstants.regionCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<StateListModel> getStates() async {
    try {
      var response =
          await firestore.collection(FirebaseConstants.stateCollection).get();
      if (response.size > 0) {
        var data = StateListModel.fromMap(response.docs);
        return data;
      }
      return StateListModel(regionList: []);
    } catch (e) {
      return StateListModel.error("Something went wrong");
      throw Exception(e);
    }
  }

  Future<ProductListModel> getProductList({String? catId}) async {
    print("403 working $catId");
    try {
      Query<Map<String, dynamic>> query =
          firestore.collection(FirebaseConstants.productCollection);
      if (catId != null) {
        query = firestore
            .collection(FirebaseConstants.productCollection)
            .where('category_id', isEqualTo: catId);
      }
      var response = await query.get();
      if (response.size > 0) {
        var data = ProductListModel.fromMap(response.docs);
        return data;
      }
      print("416 working ${response.size}");
      return ProductListModel(productList: []);
    } catch (e) {
      // return ProductListModel.error("Something went wrong");
      throw Exception(e);
    }
  }

  Future<bool> createProduct(
    String productName,
    double productPrice,
    String productDescription,
    String productImage,
    String categoryName,
    int quantity,
    String qtyType,
    String categoryId,
    String weight,
  ) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.productCollection)
          .doc()
          .set({
        'name': productName,
        'price': productPrice,
        'description': productDescription,
        'image': productImage,
        'created_at': Timestamp.now(),
        'categoryname': categoryName,
        'category_id': categoryId,
        'qty': quantity,
        'weight': weight,
        'qty_type': qtyType
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(String productName, String productPrice,
      String productDescription, String productImage, String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.productCollection)
          .doc(docId)
          .update({
        'name': productName,
        'price': productPrice,
        'description': productDescription,
        'image': productImage,
        'created_at': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(String docId) async {
    try {
      await firestore
          .collection(FirebaseConstants.productCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createProductCategory(String categoryName) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.productCategoryCollection)
          .doc()
          .set({
        'name': categoryName,
        'created_at': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> createOrder(String categoryName) async {
  //   try {
  //     var response = await firestore
  //         .collection(FirebaseConstants.orderCollection)
  //         .doc()
  //         .set({
  //       'address': address,
  //       'created_at': Timestamp.now(),
  //       'status': 'pending',
  //     });
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<ProductCategoryModelList> getProductsCategory() async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.productCategoryCollection)
          .get();
      if (response.size > 0) {
        var data = ProductCategoryModelList.fromMap(response.docs);
        return data;
      }
      return ProductCategoryModelList(categoryList: []);
    } catch (e) {
      return ProductCategoryModelList.error("Something went wrong");
      throw Exception(e);
    }
  }

  Future<bool> updateProductCategory(String categoryName, String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.productCategoryCollection)
          .doc(docId)
          .update({
        'name': categoryName,
        'created_at': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProductCategory(String docId) async {
    try {
      await firestore
          .collection(FirebaseConstants.productCategoryCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateRegion(
      String regionName, String stateId, String docId) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.regionCollection)
          .doc(docId)
          .update({
        'name': regionName,
        'state_id': stateId,
        'created_at': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<GetNotesModel>> getNotes() async {
    try {
      var response =
          await firestore.collection(FirebaseConstants.notesCollection).get();
      print("Fetched ${response.size} notes.");

      // Check if the collection has documents
      if (response.docs.isNotEmpty) {
        // Map each document to a GetNotesModel instance
        List<GetNotesModel> notesList = response.docs.map((doc) {
          print("length: ${response.docs.length}");
          return GetNotesModel.fromMap(
              doc.id, doc.data() as Map<String, dynamic>);
        }).toList();

        return notesList;
      }

      // Return an empty list if no notes are found
      return [];
    } catch (e) {
      print("Error fetching notes: $e");
      throw Exception("Something went wrong while fetching notes.");
    }
  }

  Future<bool> createNotes(String title, String description) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.notesCollection)
          .doc()
          .set({
        'title': title,
        'description': description,
        'created_at': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNotes(String docId) async {
    try {
      await firestore
          .collection(FirebaseConstants.notesCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImageToFirebaseStorage(
      String imagePath, String uploadFolder,
      {String? extension}) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child(uploadFolder)
        .child(DateTime.now().toString() + (imagePath.split('.').last));
    final UploadTask uploadTask = storageReference.putFile(File(imagePath));
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future<List<GetDealerListModel>> getDealersList() async {
    try {
      var response =
          await firestore.collection(FirebaseConstants.dealersCollection).get();

      if (response.docs.isNotEmpty) {
        // Map each document to a GetDealerListModel object.
        List<GetDealerListModel> dealerList = response.docs.map((doc) {
          return GetDealerListModel.fromMap(
              doc.id, doc.data() as Map<String, dynamic>);
        }).toList();

        return dealerList;
      }
      return [];
    } catch (e) {
      throw Exception("Error fetching dealers: $e");
    }
  }

  Future<bool> createDealer({
    required String name,
    required String region,
    required int phone,
    required String createdBy,
    required String docId,
    required String shopName,
  }) async {
    try {
      var response = await firestore
          .collection(FirebaseConstants.dealersCollection)
          .doc()
          .set({
        'name': name,
        'region': region,
        'phone': phone,
        'created_at': Timestamp.now(),
        'created_by': createdBy,
        'doc_id': docId,
        'shop_name': shopName,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDealer(String docId) async {
    try {
      await firestore
          .collection(FirebaseConstants.dealersCollection)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
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
