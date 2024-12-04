import 'package:flutter/material.dart';
import 'package:sah_food_industries/models/product_model.dart';
import 'package:sah_food_industries/services/firebase_services.dart';
import 'package:sah_food_industries/utils/toast_helper.dart';
import '../models/product_category_model.dart';
import '../routes/routes.dart';

class ProductCategoryProvider extends ChangeNotifier {
  ProductCategoryProvider() {
    getProductCategory();
  }

  final FirebaseServices _firebaseServices = FirebaseServices();

  List<ProductCategoryModel>? categoryList;
  List<ProductCategoryModel>? staffListSearch;
  TextEditingController searchController = TextEditingController();

  List<ProductModel>? productList;
  bool productLoading = false;

  getProductCategory() async {
    var data = await _firebaseServices.getProductsCategory();
    categoryList = data.categoryList;
    staffListSearch = data.categoryList;
    notifyListeners();
  }

  getProducts(String? catId) async {
    var data = await _firebaseServices.getProductList(catId: catId);
    productList = data.productList ?? [];
    // List<ProductCategoryModel> cat1 = [];
    // List<ProductCategoryModel> cat2 = [];
    // for (ProductCategoryModel i in categoryList ?? []) {
    //   if (i.docId == catId) {
    //     cat1.add(i);
    //   } else {
    //     cat2.add(i);
    //   }
    // }
    // categoryList = cat1 + cat2;
    notifyListeners();
  }

  createProduct(
      {context,
      required String productName,
      required String productPrice,
      required String productDescription,
      required String productImage,
      required String categoryName,
      required String categoryId,
      required String quantity,
      required String qtyType,
      required String weight}) async {
    if (productPrice.isEmpty ||
        productName.isEmpty ||
        productDescription.isEmpty ||
        productImage.isEmpty ||
        categoryName.isEmpty ||
        quantity.isEmpty ||
        qtyType.isEmpty ||
        categoryId.isEmpty ||
        weight.isEmpty) {
      ToastHelper.showToast("all fields are required");
      return;
    }
    weight = weight + " " + qtyType;
    double price = double.tryParse(productPrice) ?? 0;
    int qty = int.tryParse(quantity) ?? 0;
    productLoading = true;
    notifyListeners();
    String url = await _firebaseServices.uploadImageToFirebaseStorage(
        productImage, 'productUploads');
    var data = await _firebaseServices.createProduct(
        productName,
        price,
        productDescription,
        url,
        categoryName,
        qty,
        qtyType,
        categoryId,
        weight);
    getProducts(categoryId);
    productLoading = false;
    notifyListeners();
    ToastHelper.showToast("Product Uploaded");
    Navigator.pushNamed(context, Routes.catalogScreen);
  }

  updateProduct(
      {context,
      required String productName,
      required String productPrice,
      required String productDescription,
      required String productImage,
      required String categoryName,
      required String categoryId,
      required String quantity,
      required String qtyType,
      required String weight,
      required String docId}) async {
    print("104 Working update product");
    if (productPrice.isEmpty ||
        productName.isEmpty ||
        productDescription.isEmpty ||
        productImage.isEmpty ||
        categoryName.isEmpty ||
        quantity.isEmpty ||
        qtyType.isEmpty ||
        categoryId.isEmpty ||
        weight.isEmpty) {
      ToastHelper.showToast("all fields are required");
      return;
    }

    double price = double.tryParse(productPrice) ?? 0;
    int qty = int.tryParse(quantity) ?? 0;
    productLoading = true;
    notifyListeners();
    String url = await _firebaseServices.uploadImageToFirebaseStorage(
        productImage, 'productUploads');
    var data = await _firebaseServices.updateProduct(
      productName,
      // price,
      productDescription,
      url,
      categoryName,
      // qty,
      qtyType,
      // categoryId,
      // weight,
      // docId
    );

    getProducts(categoryId);
    productLoading = false;
    notifyListeners();
    ToastHelper.showToast("Product Updated");
    Navigator.pushNamed(context, Routes.catalogScreen);
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
