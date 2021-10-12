import 'package:flutter/material.dart';
import 'package:yummy_chat/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yummy_chat/screens/chat_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot){
          if(userSnapshot.hasData){
            return ChatScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}
