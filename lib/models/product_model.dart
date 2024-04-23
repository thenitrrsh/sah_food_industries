import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListModel{
  List<ProductModel>? regionList;
  String? error;

  ProductListModel({
    this.regionList,
    this.error,
  });

  factory ProductListModel.fromMap(List<QueryDocumentSnapshot> map) {
    List<ProductModel> regionList = [];
    map.forEach((element) {
      regionList.add(ProductModel.fromMap(element.id, element.data() as Map<String, dynamic>));
    });
    return ProductListModel(regionList: regionList);
  }

  Map<String, dynamic> toMap() {
    return {
      'regionList': regionList!.map((e) => e.toMap()).toList(),
    };
  }
  ProductListModel.error(String this.error);
}

class ProductModel {
  String? stateName;
  String? docId;


  ProductModel({
    this.stateName,
    this.docId,

  });

  factory ProductModel.fromMap(String docId, Map<String, dynamic> map) {
    return ProductModel(
      docId: docId,
      stateName: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': stateName,

    };
  }
}


