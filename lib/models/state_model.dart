
import 'package:cloud_firestore/cloud_firestore.dart';

class StateListModel{
  List<StateModel>? regionList;
  String? error;

  StateListModel({
    this.regionList,
    this.error,
  });

  factory StateListModel.fromMap(List<QueryDocumentSnapshot> map) {
    List<StateModel> regionList = [];
    map.forEach((element) {
      regionList.add(StateModel.fromMap(element.id, element.data() as Map<String, dynamic>));
    });
    return StateListModel(regionList: regionList);
  }

  Map<String, dynamic> toMap() {
    return {
      'regionList': regionList!.map((e) => e.toMap()).toList(),
    };
  }
  StateListModel.error(String this.error);
}

class StateModel {
  String? stateName;
  String? docId;


  StateModel({
    this.stateName,
    this.docId,

  });

  factory StateModel.fromMap(String docId, Map<String, dynamic> map) {
    return StateModel(
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


