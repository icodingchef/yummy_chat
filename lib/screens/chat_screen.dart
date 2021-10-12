import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yummy_chat/widgets/chat/message.dart';
import 'package:yummy_chat/widgets/chat/new_message.dart';

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

  void getCurrentUser() {
    try {
      final user = _auth.currentUser!;
      loggedInUser = user;
      print(loggedInUser!.email);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter chatting'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
          ),
          // DropdownButton(
          //   dropdownColor: Colors.black,
          //   items: [
          //     DropdownMenuItem(
          //       child: Container(
          //         child: Row(
          //           children: [
          //             Icon(
          //               Icons.exit_to_app,
          //               color: Colors.grey,
          //             ),
          //             SizedBox(
          //               width: 8,
          //             ),
          //             Text('Logout')
          //           ],
          //         ),
          //       ),
          //       value: 'logout',
          //     ),
          //   ],
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Colors.white,
          //   ),
          //   onChanged: (verify) {
          //     if (verify == 'logout') {
          //       FirebaseAuth.instance.signOut();
          //     }
          //   },
          // ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
