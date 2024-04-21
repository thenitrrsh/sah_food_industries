class UserModel {
  String? name;
  dynamic createdAt;
  String? password;
  String? phone;
  String? email;
  String? docId;
  int? totalStaff;
  String? regionId;
  String? regionName;
  String? stateId;
  String? stateName;
  String? type;
  String? status;


  UserModel({
     this.password,
     this.name,
     this.createdAt,
     this.phone,
     this.email,
    this.docId,
    this.totalStaff,
    this.type,
    this.regionId,
    this.regionName,
    this.stateId,
    this.stateName,
    this.status,

  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      password: map['password'],
      name: map['name'],
      createdAt: map['created_at'],
      phone: map['phone'],
      email: map['email'],
      type: map['type'],
      docId: map['docId'],
      regionId: map['region_id'],
      regionName: map['region_name'],
      stateId: map['state_id'],
      stateName: map['state_name'],
      status: map['status'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'name': name,
      'created_at': createdAt,
      'phone': phone,
      'email': email,
      'docId': docId,
      'type': type,
      'region_id': regionId,
      'region_name': regionName,
      'state_id': stateId,
      'state_name': stateName,
    };
  }
}
