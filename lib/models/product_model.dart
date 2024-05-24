import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListModel {
  List<ProductModel>? productList;
  String? error;

  ProductListModel({
    this.productList,
    this.error,
  });

  factory ProductListModel.fromMap(List<QueryDocumentSnapshot> map) {
    List<ProductModel> productList = [];
    map.forEach((element) {
      productList.add(ProductModel.fromMap(
          element.id, element.data() as Map<String, dynamic>));
    });
    return ProductListModel(productList: productList);
  }

  Map<String, dynamic> toMap() {
    return {
      'productList': productList!.map((e) => e.toMap()).toList(),
    };
  }

  ProductListModel.error(String this.error);
}

class ProductModel {
  String? name;
  String? docId;
  String? catId;
  String? image;
  double? price;
  String? description;
  String? weight;

  ProductModel(
      {this.name,
      this.docId,
      this.catId,
      this.image,
      this.price,
      this.description,
      this.weight});

  factory ProductModel.fromMap(String docId, Map<String, dynamic> map) {
    return ProductModel(
        docId: docId,
        name: map['name'],
        catId: map['category_id'],
        image: map['image'],
        price: map['price'],
        description: map['description'],
        weight: map['weight']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category_id': catId,
      'image': image,
      'price': price,
      'description': description,
      'weight': weight
    };
  }
}
