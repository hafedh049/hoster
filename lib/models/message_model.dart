final class MessageModel {
  final String uid;
  final String id;
  final String message;
  final DateTime timestamp;
  final String isYou;

  MessageModel({
    required this.uid,
    required this.id,
    required this.message,
    required this.timestamp,
    required this.isYou,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      uid: json['uid'],
      id: json['id'],
      message: json['message'],
      timestamp: DateTime(
        int.parse(json['timestamp'].split(" ")[0].split("-")[0]),
        int.parse(json['timestamp'].split(" ")[0].split("-")[1]),
        int.parse(json['timestamp'].split(" ")[0].split("-")[2]),
        int.parse(json['timestamp'].split(" ")[1].split(":")[0]),
        int.parse(json['timestamp'].split(" ")[1].split(":")[1]),
        int.parse(json['timestamp'].split(" ")[1].split(":")[2]),
      ),
      isYou: json['isYou'],
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'id': id,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isYou': isYou,
    };
  }
}
