class MessagesUser {
  late String text;
  late String senderId;
  late String receiverId;
  late String dateTime;

  MessagesUser({
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
  });

  MessagesUser.fromJson(Map<String, dynamic>? json) {
    text = json!["text"];
    senderId = json["sender_id"];
    receiverId = json["receiver_id"];
    dateTime = json["date_time"];

  }

  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "sender_id": senderId,
      "receiver_id": receiverId,
      "date_time": dateTime,
    };
  }
}
