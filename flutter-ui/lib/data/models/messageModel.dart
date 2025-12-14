import 'dart:convert';

class MessageModel {
  double confidenceScore;
  int id;
  String message;
  String response;
  String sender;
  String tags;
  DateTime timestamp;

  MessageModel({
    required this.confidenceScore,
    required this.id,
    required this.message,
    required this.response,
    required this.sender,
    required this.tags,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String,dynamic> json){
    return MessageModel(
        confidenceScore: json["confidenceScore"],
        id: json["id"],
        message: json["message"],
        response: json["response"],
        sender: json['sender'],
        tags: json['tags'],
        timestamp: json['timestamp']
    );
  }
}
