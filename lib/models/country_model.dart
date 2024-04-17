
class CountryListModel{
  List<CountryModel>? countryList;
  String? error;

  CountryListModel({
    this.countryList,
    this.error,
  });

  factory CountryListModel.fromMap(List<dynamic> map) {
    List<CountryModel> countryList = [];
    map.forEach((element) {
      countryList.add(CountryModel.fromMap(element['docId'], element['data']));
    });
    return CountryListModel(
      countryList: countryList,
    );
  }

  CountryListModel.error(String this.error);

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> list = [];
    countryList!.forEach((element) {
      list.add(element.toMap());
    });
    return {
      'countryList': list,
    };
  }

}
class CountryModel {
  String? countryName;
  String? docId;

  CountryModel({
    this.countryName,
    this.docId,
  });

  factory CountryModel.fromMap(String docId, Map<String, dynamic> map) {
    return CountryModel(
      docId: docId,
      countryName: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': countryName,
    };
  }
}