final class MessageModel {
  final String id;
  final String message;
  final DateTime timestamp;
  final String sender;
  final List<String> reacts;

  MessageModel({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.sender,
    required this.reacts,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      message: json['message'],
      timestamp: json['timestamp'],
      sender: json['sender'],
      reacts: json['reacts'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'message': message,
        'timestamp': timestamp,
        'sender': sender,
        'reacts': reacts,
      };
}
