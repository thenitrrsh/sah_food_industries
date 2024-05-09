import 'package:flutter/material.dart';
import 'package:sah_food_industries/services/firebase_services.dart';
import '../../../models/product_category_model.dart';

class AddProductProvider extends ChangeNotifier {
  AddProductProvider() {
    getProductCategory();
  }

  final FirebaseServices _firebaseServices = FirebaseServices();

  List<ProductCategoryModel>? categoryList;
  List<ProductCategoryModel>? staffListSearch;
  TextEditingController searchController = TextEditingController();

  getProductCategory() async {
    var data = await _firebaseServices.getProductsCategory();
    categoryList = data.categoryList;
    notifyListeners();
  }

  searchData() {
    if (searchController.text.isEmpty) {
      staffListSearch = categoryList;
    } else {
      staffListSearch = categoryList!
          .where((element) => element.name!
              .toLowerCase()
              .contains(searchController.text.trim().toLowerCase()))
          .toList();
    }

    notifyListeners();
  }
}
