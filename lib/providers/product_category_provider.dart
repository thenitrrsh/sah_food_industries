import 'package:flutter/material.dart';
import 'package:sah_food_industries/services/firebase_services.dart';
import '../models/product_category_model.dart';


class ProductCategoryProvider extends ChangeNotifier{

  ProductCategoryProvider(){
    getProductCategory();
  }

  final FirebaseServices _firebaseServices = FirebaseServices();

  List<ProductCategoryModel>? categoryList ;
  List<ProductCategoryModel>? staffListSearch ;
  TextEditingController searchController = TextEditingController();

  getProductCategory() async {
    var data = await _firebaseServices.getProductsCategory();
    categoryList = data.categoryList;
    staffListSearch = data.categoryList;
    notifyListeners();
  }

  searchData(){
    if(searchController.text.isEmpty){
      staffListSearch = categoryList;

    }else {
      staffListSearch = categoryList!.where((element) => element.name!.toLowerCase().contains(searchController.text.trim().toLowerCase())).toList();
    }
  
    notifyListeners();
  }






}