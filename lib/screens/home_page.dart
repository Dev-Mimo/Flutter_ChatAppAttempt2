import 'package:flutter/material.dart';

// State:
import 'package:provider/provider.dart';
import 'package:firebase_chatapp/state/theme.dart';

// Screens:

// Models:
import 'package:firebase_chatapp/models/user.dart';
import 'package:firebase_chatapp/models/room.dart';
import 'package:firebase_chatapp/models/message.dart';

// Services:
import 'package:firebase_chatapp/services/auth.dart';
import 'package:firebase_chatapp/services/database.dart';

// Firebase stuff:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Custom:
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const MyHomePage({required this.auth, required this.firestore});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              final String? returnValue = await Auth(auth: widget.auth).signOut();
              if (returnValue == "Success") {}
            },
            icon: Icon(Icons.add_to_home_screen),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream:
                  Database(auth: widget.auth, firestore: widget.firestore).retrieveMessagesFromDB(),
              builder: (BuildContext context, AsyncSnapshot<List<MessageModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text("Nothing..."),
                    );
                  }
                }
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return snapshot.data![index].messageId == "1" ? Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("${snapshot.data![index].content}"),
                      ),
                    )
                    : Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${snapshot.data![index].content}"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          FormBuilder(
            key: _formKey,
            child: FormBuilderTextField(
              name: 'chat_box',
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
