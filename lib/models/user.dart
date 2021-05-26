// State:

// Screens:

// Models:

// Services:

// Firebase stuff:
import 'package:cloud_firestore/cloud_firestore.dart';

// Custom:

class UserModel {
  late String userId;
  late String email;
  late bool emailVerified;
  late Metadata metadata;
  late String name;
  late String? photoURL;
  late String provider;
  late String? about;

  UserModel(
      {required this.userId,
      required this.email,
      required this.emailVerified,
      required this.metadata,
      required this.name,
      this.photoURL,
      required this.provider,
      this.about});

  UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> documentSnapshot}) {
    userId = documentSnapshot.reference.id;
    email = documentSnapshot.data()!['email'] as String;
    emailVerified = documentSnapshot.data()!['emailVerified'] as bool;
    metadata = Metadata(
        creation_time: documentSnapshot.data()!['metadata']['creationTime'] as Timestamp,
        lastSignIn_time: documentSnapshot.data()!['metadata']['lastSignInTime'] as Timestamp);
    name = documentSnapshot.data()!['name'] as String;
    photoURL = documentSnapshot.data()!['photoURL'] as String?;
    provider = documentSnapshot.data()!['provider'] as String;
    about = documentSnapshot.data()!['about'] as String?;
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'emailVerified': emailVerified,
    'metadata': Metadata(creation_time: metadata.creation_time, lastSignIn_time: metadata
        .lastSignIn_time).toJson(),
    'name': name,
    'photoURL': photoURL,
    'provider': provider,
    'about': about
  };
}

class Metadata {
  // ignore: non_constant_identifier_names
  late Timestamp creation_time;
  // ignore: non_constant_identifier_names
  late Timestamp lastSignIn_time;

  late DateTime creationTime;
  late DateTime lastSignInTime;

  // ignore: non_constant_identifier_names
  Metadata({required this.creation_time, required this.lastSignIn_time}) {
    creationTime = creation_time.toDate();
    lastSignInTime = lastSignIn_time.toDate();
  }

  Map<String, dynamic> toJson() => {
    'creationTime': creationTime,
    'lastSignInTime': lastSignInTime
  };
}
