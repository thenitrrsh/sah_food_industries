
import 'package:cloud_firestore/cloud_firestore.dart';

class RegionListModel{
  List<RegionModel>? regionList;
  String? error;

  RegionListModel({
    this.regionList,
    this.error,
  });

  factory RegionListModel.fromMap(List<QueryDocumentSnapshot> map) {
    List<RegionModel> regionList = [];
    map.forEach((element) {
      regionList.add(RegionModel.fromMap(element.id, element.data() as Map<String, dynamic>));
    });
    return RegionListModel(regionList: regionList);
  }

  Map<String, dynamic> toMap() {
    return {
      'regionList': regionList!.map((e) => e.toMap()).toList(),
    };
  }
  RegionListModel.error(String this.error);
}

class RegionModel {
  String? regionName;
  String? docId;
  String? countryId;
  String? stateId;

  RegionModel({
    this.regionName,
    this.docId,
    this.countryId,
    this.stateId,
  });

  factory RegionModel.fromMap(String docId, Map<String, dynamic> map) {
    return RegionModel(
      docId: docId,
      regionName: map['name'],
      stateId: map['state_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': regionName,
      'country_id': countryId,
      'state_id': stateId,
    };
  }
}


