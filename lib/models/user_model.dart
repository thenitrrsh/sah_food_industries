


class UserModel {
  String? name;
  dynamic createdAt;
  String? password;
  String? phone;
  String? email;
  String? tvID;
  String? docId;
  int? totalStaff;

  UserModel({
     this.password,
     this.name,
     this.createdAt,
     this.phone,
     this.email,
     this.tvID,
    this.docId,
    this.totalStaff
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      password: map['password'],
      name: map['name'],
      createdAt: map['created_at'],
      phone: map['phone'],
      email: map['email'],
      tvID: map['tv_id_final'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'name': name,
      'created_at': createdAt,
      'phone': phone,
      'email': email,
      'tv_id_final': tvID,
    };
  }
}
