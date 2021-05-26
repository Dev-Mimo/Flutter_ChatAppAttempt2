// State:

// Screens:

// Models:

// Services:

// Firebase stuff:
import 'package:cloud_firestore/cloud_firestore.dart';

// Custom:

class RoomModel {
  late String roomId;
  late String type;
  late List userIds;
  late String imgURL;
  late String name;
  // ignore: non_constant_identifier_names
  late Timestamp created_at;
  late DateTime createdAt;
  late String createdBy;

  RoomModel(
      {required this.roomId,
      required this.type,
      required this.userIds,
      required this.imgURL,
      required this.name,
      required this.createdAt,
      required this.createdBy});

  RoomModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> documentSnapshot}) {
    roomId = documentSnapshot.reference.id;
    type = documentSnapshot.data()!['type'] as String;
    userIds = documentSnapshot.data()!['userIds'] as List;
    imgURL = documentSnapshot.data()!['imgURL'] as String;
    name = documentSnapshot.data()!['name'] as String;
    created_at = documentSnapshot.data()!['createdAt'] as Timestamp;
    createdAt = created_at.toDate();
    createdBy = documentSnapshot.data()!['createdBy'] as String;
  }

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'type': type,
        'userIds': userIds,
        'imgURL': imgURL,
        'name': name,
        'createdAt': created_at,
        'createdBy': createdBy
      };
}
