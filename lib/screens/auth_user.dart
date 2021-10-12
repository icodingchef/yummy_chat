// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'auth_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthUser extends StatefulWidget {
//   const AuthUser({Key? key}) : super(key: key);
//
//   @override
//   _AuthUserState createState() => _AuthUserState();
// }
//
// class _AuthUserState extends State<AuthUser> {
//   final auth = FirebaseAuth.instance;
//   UserCredential? userCredential;
//
//   void submitAuthForm(
//       String? email, String? password, String? userName, bool isLogin) async {
//
//
//     try {
//       if (isLogin) {
//         userCredential = await auth.signInWithEmailAndPassword(
//           email: email!,
//           password: password!,
//         );
//       } else {
//         userCredential = await auth.createUserWithEmailAndPassword(
//           email: email!,
//           password: password!,
//         );
//       }
//     } on PlatformException catch (e) {
//       var message = 'An error occurred';
//       if (e.message != null) {
//         message = e.message!;
//       }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.blue,
//         ),
//       );
//     }catch(e){
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LoginSignupScreen(),
//     );
//   }
// }
