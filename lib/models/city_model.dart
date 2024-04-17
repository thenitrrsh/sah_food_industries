class CityModel {
  String? stateName;
  String? docId;
  String? countryId;
  String? stateId;

  CityModel({
    this.stateName,
    this.docId,
    this.countryId,
    this.stateId,
  });

  factory CityModel.fromMap(String docId, Map<String, dynamic> map) {
    return CityModel(
      docId: docId,
      stateName: map['name'],
      countryId: map['country_id'],
      stateId: map['state_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': stateName,
      'country_id': countryId,
      'state_id': stateId,
    };
  }
}


