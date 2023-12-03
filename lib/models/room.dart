import 'package:flutter_messagerie/models/message.dart';

class Room {
  Room({
    required this.id,
    required this.createdAt,
    required this.otherUserId,
    this.lastMessage,
  });

  final String id;
  final DateTime createdAt;
  final String otherUserId;
  final Message? lastMessage;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  Room.fromRoomParticipants(Map<String, dynamic> map)
      : id = map['room_id'],
        otherUserId = map['profile_id'],
        createdAt = DateTime.parse(map['created_at']),
        lastMessage = null;

  Room copyWith({
    String? id,
    DateTime? createdAt,
    String? otherUserId,
    Message? lastMessage,
  }) {
    return Room(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      otherUserId: otherUserId ?? this.otherUserId,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
