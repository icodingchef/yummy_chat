import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try {
      final user = _auth.currentUser!;
      loggedInUser = user;
      print(loggedInUser!.email);
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index)=> Container(
          padding: EdgeInsets.all(8.0),
          child: Text('This works'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          FirebaseFirestore.instance.collection('chats/piUsQ6lLjgD9P2GdQUvz/message')
              .snapshots()
              .listen((event) {
                //print(event.docs[0]['text']);
            event.docs.forEach((element) {
              print(element['text']);
            });
          });
        },
      ),
    );
  }
}
