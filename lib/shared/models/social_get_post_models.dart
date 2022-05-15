class SocialGetPost {
  late String postImage;
  late String profileImage;
  late String name;
  late String uid;
  late String date;
  late String text;
  late String postId;
  late bool isLiked;
  late int numLike;

  SocialGetPost(
      {
        required this.numLike,
        required this.postImage,
        required this.profileImage,
        required this.name,
        required this.postId,
        required this.date,
        required this.text,
        required this.uid,
        required this.isLiked,
      });

  SocialGetPost.fromJson(Map<String, dynamic>? json, Map<String, dynamic> json1) {
    postImage = json!["post_image"];
    profileImage = json1["profile_image"];
    numLike = json1["num_like"];
    postId = json1["post_id"];
    isLiked = json1["is_liked"];
    date = json["date"];
    text = json["text"];
    name = json1["name"];
    uid = json["uid"];
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "name": name,
      "post_image": postImage,
      "num_like": numLike,
      "post_id": postId,
      "is_liked": isLiked,
      "profile_image": profileImage,
      "text": text,
      "uid": uid,
    };
  }
}
