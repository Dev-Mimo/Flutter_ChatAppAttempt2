// State:

// Screens:

// Models:

// Services:

// Firebase stuff:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Custom:

class MessageModel {
  late String messageId;
  late String messageAuthId;
  late String type;
  late String content;
  // ignore: non_constant_identifier_names
  late Timestamp sent_at;
  late DateTime sentAt;
  late String status;
  late String? fileName;
  late String? mimeType;
  late String? size;
  late String? url;

  MessageModel(
      {required this.messageId,
      required this.messageAuthId,
      required this.type,
      required this.content,
      required this.sentAt,
      required this.status,
      this.fileName,
      this.mimeType,
      this.size,
      this.url});

  MessageModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> documentSnapshot}) {
    messageId = documentSnapshot.data()!['messageId'] as String;
    messageAuthId = FirebaseAuth.instance.currentUser!.uid;
    type = documentSnapshot.data()!['type'] as String;
    content = documentSnapshot.data()!['content'] as String;
    sent_at = documentSnapshot.data()!['sentAt'] as Timestamp;
    sentAt = sent_at.toDate();
    status = documentSnapshot.data()!['status'] as String;
    fileName = documentSnapshot.data()?['fileName'] ?? null;
    mimeType = documentSnapshot.data()?['mimeType'] ?? null;
    size = documentSnapshot.data()?['size'] ?? null;
    url = documentSnapshot.data()?['url'] ?? null;
  }

  Map<String, dynamic> toJson() => {
        'messageId': messageId,
        'messageAuthId': messageAuthId,
        'type': type,
        'content': content,
        'sentAt': sent_at,
        'status': status,
        'fileName': fileName,
        'mimeType': mimeType,
        'size': size,
        'url': url
      };
}
