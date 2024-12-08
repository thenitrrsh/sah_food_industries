import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GetDealerListModel {
  DateTime? createdAt;
  String? createdBy;
  String? docId;
  String? name;
  int? phone;
  String? region;
  String? shopName;

  GetDealerListModel({
    this.createdAt,
    this.createdBy,
    this.docId,
    this.name,
    this.phone,
    this.region,
    this.shopName,
  });

  factory GetDealerListModel.fromMap(String docId, Map<String, dynamic> json) {
    DateTime? date = (json['created_at'] as Timestamp?)?.toDate();

    return GetDealerListModel(
      createdAt: date,
      createdBy: json["created_by"],
      docId: docId,
      name: json["name"],
      phone: json["phone"],
      region: json["region"],
      shopName: json["shop_name"],
    );
  }

  Map<String, dynamic> toMap() => {
        "created_at": createdAt,
        "created_by": createdBy,
        "doc_id": docId,
        "name": name,
        "phone": phone,
        "region": region,
        "shop_name": shopName,
      };
}
