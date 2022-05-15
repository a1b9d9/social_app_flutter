class SocialInfoUser {
 late String name;
 late String phone;
 late String email;
 late String profileImage;
 late String coverImage;
 late String bio;
 late String uId;
  bool isEmailVerified = false;

  SocialInfoUser(
      {required this.name,
      required this.email,
      required this.profileImage,
      required this.coverImage,
      required this.bio,
      required this.phone,
      required this.uId,
      this.isEmailVerified = false});

  SocialInfoUser.fromJson(Map<String, dynamic>? json) {
    name = json!["name"];
    phone = json["phone"];
    email = json["email"];
    profileImage = json["profile_image"];
    coverImage = json["cover_image"];
    bio = json["bio"];
    uId = json["uId"];
    isEmailVerified = json["isEmailVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "profile_image": profileImage,
      "cover_image": coverImage,
      "bio": bio,
      "phone": phone,
      "uId": uId,
      "isEmailVerified": isEmailVerified,
    };
  }
}
