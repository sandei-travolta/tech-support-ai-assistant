import 'dart:convert';

class MessageModel {
  double? confidenceScore;
  int id;
  String message;
  String? response;
  String sender;
  String? tags;
  String? urgencey;
  DateTime timestamp;

  MessageModel({
    this.confidenceScore,
    required this.id,
    required this.message,
    this.response,
    required this.sender,
    this.tags,
    required this.timestamp,
    this.urgencey
  });

  factory MessageModel.fromJson(Map<String,dynamic> json){
    return MessageModel(
        confidenceScore: json["confidenceScore"],
        id: json["id"],
        message: json["message"],
        response: json["response"],
        sender: json['sender'],
        tags: json['tags'],
      timestamp: DateTime.parse(json["timestamp"]),
        urgencey: json['urgency']

    );
  }
}
