class SocialAddPost {
  late String postImage;
  late String uid;
  late String date;
  late String text;

  SocialAddPost(
      {
        required this.postImage,
        required this.date,
        required this.text,
        required this.uid,
      });

  SocialAddPost.fromJson(Map<String, dynamic>? json) {
    postImage = json!["post_image"];
    date = json["date"];
    text = json["text"];
    uid = json["uid"];
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "post_image": postImage,
      "text": text,
      "uid": uid,
    };
  }
}
