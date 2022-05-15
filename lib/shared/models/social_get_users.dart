class SocialGetUser {
  late String name;
  late String profileImage;
  late String uId;
  late String bio;

  SocialGetUser({
    required this.name,
    required this.profileImage,
    required this.uId,
    required this.bio,
  });

  SocialGetUser.fromJson(Map<String, dynamic>? json) {
    name = json!["name"];
    profileImage = json["profile_image"];
    uId = json["uId"];
    bio = json["bio"];

  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "profile_image": profileImage,
      "uId": uId,
      "bio": bio,
    };
  }
}
