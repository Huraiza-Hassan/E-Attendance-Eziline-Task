class UserModel {
  late String name;
  late String userType;
  late String userEmail;

  UserModel(
      {required this.name, required this.userType, required this.userEmail});

  Map<String, dynamic> toMap() {
    return {'userName': name, 'userType': userType, 'userEmail': userEmail};
  }

  UserModel.fromJson(Map<dynamic, dynamic> userMap) {
    name = userMap['userName'];
    userType = userMap['userType'];
    userEmail = userMap['userEmail'];
  }
}
