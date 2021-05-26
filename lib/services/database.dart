// State:

// Screens:

// Models:
import 'package:firebase_chatapp/models/message.dart';
import 'package:firebase_chatapp/models/user.dart';
import 'package:firebase_chatapp/models/room.dart';

// Services:

// Firebase stuff:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Custom:

class Database {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Database({required this.auth, required this.firestore});

  Stream<List<UserModel>> retrieveUsersFromDB() {
    try {
      return firestore
          .collection("users")
          // .where("done", isEqualTo: false)
          .snapshots()
          .map((QuerySnapshot<Map<String, dynamic>> query) {
        final List<UserModel> returnValue = <UserModel>[];
        for (final DocumentSnapshot<Map<String, dynamic>> doc in query.docs) {
          returnValue.add(UserModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return returnValue;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<RoomModel>> retrieveRoomsFromDB() {
    try {
      return firestore
          .collection("rooms")
          // .where("done", isEqualTo: false)
          .snapshots()
          .map((QuerySnapshot<Map<String, dynamic>> query) {
        final List<RoomModel> returnValue = <RoomModel>[];
        for (final DocumentSnapshot<Map<String, dynamic>> doc in query.docs) {
          returnValue.add(RoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return returnValue;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<MessageModel>> retrieveMessagesFromDB() {
    try {
      return firestore
          .collection("rooms")
          .doc('rAOK7x138RrQDt1vvmgz')
          .collection('messages')
          // .where("done", isEqualTo: false)
          .snapshots()
          .map((QuerySnapshot<Map<String, dynamic>> query) {
        final List<MessageModel> returnValue = <MessageModel>[];
        for (final DocumentSnapshot<Map<String, dynamic>> doc in query.docs) {
          returnValue.add(MessageModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return returnValue;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser() async {
    try {
      firestore.collection("users").add(UserModel(
              email: 'asasd',
              name: 'ASD',
              provider: 'email',
              emailVerified: false,
              userId: 'asfasfascasd',
              metadata: Metadata(
                  creation_time: Timestamp.fromMillisecondsSinceEpoch(100),
                  lastSignIn_time: Timestamp.fromMillisecondsSinceEpoch(100000)))
          .toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo({required String content}) async {
    try {
      firestore.collection("users").doc(auth.currentUser!.uid).collection("todos").add({
        "content": content,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodo({required String todoId}) async {
    try {
      firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": true});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo({required String todoId}) async {
    try {
      firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("todos")
          .doc(todoId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
