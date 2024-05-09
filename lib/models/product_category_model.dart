import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/dropdown.dart';

class ProductCategoryModelList {
  List<ProductCategoryModel>? categoryList;
  String? error;

  ProductCategoryModelList({
    this.categoryList,
    this.error,
  });

  factory ProductCategoryModelList.fromMap(List<QueryDocumentSnapshot> map) {
    List<ProductCategoryModel> regionList = [];
    map.forEach((element) {
      regionList.add(ProductCategoryModel.fromMap(
          element.id, element.data() as Map<String, dynamic>));
    });
    return ProductCategoryModelList(categoryList: regionList);
  }

  Map<String, dynamic> toMap() {
    return {
      'productCategoryList': categoryList!.map((e) => e.toMap()).toList(),
    };
  }

  ProductCategoryModelList.error(String this.error);
}

class ProductCategoryModel {
  String? name;
  String? docId;

  ProductCategoryModel({
    this.name,
    this.docId,
  });

  factory ProductCategoryModel.fromMap(String docId, Map<String, dynamic> map) {
    return ProductCategoryModel(
      docId: docId,
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  map(
      DropdownMenuItem<ProductCategoryModel> Function(
              List<ProductCategoryModel> value)
          param0) {}
}
