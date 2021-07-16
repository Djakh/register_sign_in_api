class User {
 
  String? name;
  String? email;
  int? regionId;
  String? token;

  User({
    this.name,
    this.email,
    this.regionId,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
     
      name: responseData["name"] ?? ' ',
      email: responseData["email"]?? ' ',
      regionId: responseData["region_id"]?? 0,
      token: responseData["token"] ?? '0',
    );
  }
}
