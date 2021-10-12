import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yummy_chat/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yummy_chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:yummy_chat/widgets/picker/user_image_picker.dart';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  bool isSignupScreen = true;
  // bool isLoginScreen = true;
  // bool isMale = true;
  // bool isLogin = true;
  bool showSpinner = false;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  io.File? userImageFile;
  //io.File? image;

  void _pickedImage(io.File? image) {
    userImageFile = image;
  }

  void _trySubmit() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (userImageFile == null && isSignupScreen) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/red2_3.jpg'),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 60, left: 20),
                    //color: Color(0xFFF8D405).withOpacity(.45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Welcome',
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 25.0,
                                color: Color(0xFFFCFCFC),
                                //fontWeight: FontWeight.bold
                              ),
                              children: [
                                TextSpan(
                                  text: isSignupScreen
                                      ? ' to Yummy chat!'
                                      : ' back',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFCFCFC),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          isSignupScreen
                              ? 'Signup to continue'
                              : 'Signin to continue',
                          style:
                              TextStyle(letterSpacing: 1, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: 140,
                child: SingleChildScrollView(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    padding: EdgeInsets.all(20),
                    height: isSignupScreen ? 370 : 250,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignupScreen = false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: !isSignupScreen
                                              ? Palette.activeColor
                                              : Palette.textColor1),
                                    ),
                                    if (!isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignupScreen = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSignupScreen
                                              ? Palette.activeColor
                                              : Palette.textColor1),
                                    ),
                                    if (isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          if (isSignupScreen)
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    // Column(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     CircleAvatar(
                                    //       radius: 30,
                                    //     ),
                                    //     TextButton.icon(
                                    //       onPressed: (){},
                                    //       icon: Icon(Icons.image),
                                    //       label: Text('Add image'),
                                    //     ),
                                    //   ],
                                    // ),
                                    TextFormField(
                                      key: ValueKey(1),
                                      onChanged: (value) {
                                        userName = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 4) {
                                          return 'Please enter at least 4 characters.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userName = value!;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.account_circle,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35.0),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35.0),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: 'User name',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1)),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    TextFormField(
                                      key: ValueKey(2),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userEmail = value!;
                                      },
                                      onChanged: (value) {
                                        userEmail = value;
                                        print(userEmail);
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35.0),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35.0),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: 'email',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1)),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    TextFormField(
                                      key: ValueKey(3),
                                      onChanged: (value) {
                                        userPassword = value;
                                        print(userPassword);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return 'Please enter at least 6 characters.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userPassword = value!;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'password',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                    UserImagePicker(_pickedImage),
                                  ],
                                ),
                              ),
                            ),
                          if (!isSignupScreen)
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        userEmail = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userEmail = value!;
                                      },
                                      key: ValueKey(4),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35.0),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35.0),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: 'email',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Palette.textColor1)),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        userPassword = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return 'Please enter at least 6 characters.';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userPassword = value!;
                                      },
                                      key: ValueKey(5),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'password',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen ? 475 : 350,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (isSignupScreen) {
                          _trySubmit();
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                              email: userEmail.trim(),
                              password: userPassword.trim(),
                            );

                            final ref = FirebaseStorage.instance
                                .ref()
                                .child('user_image')
                                .child(newUser.user!.uid + '.jpg');
                            await ref.putFile(userImageFile!);
                            final url = await ref.getDownloadURL();

                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(newUser.user!.uid)
                                .set(
                              {
                                'username': userName,
                                'email': userEmail,
                                'image_url' : url,
                              },
                            );

                            if (newUser.user != null)
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChatScreen();
                              }));

                            setState(() {
                              showSpinner = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('등록되었습니다.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } on PlatformException catch (e) {
                            var message = 'An error occurred';
                            if (e.message != null) {
                              message = e.message!;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          } catch (e) {
                            print(e);

                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } else if (!isSignupScreen) {
                          setState(() {
                            showSpinner = true;
                          });
                          _trySubmit();
                          try {
                            final newUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: userEmail.trim(),
                                    password: userPassword.trim());

                            // if (newUser.user != null)
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) {
                            //     return ChatScreen();
                            //   }));

                            //ChatScreen이 두 번 호출되었던 이유. 코드 삭제해줌

                            setState(() {
                              showSpinner = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('로그인 되었습니다.'),
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 700),
                              ),
                            );
                          } on PlatformException catch (e) {
                            var message = 'An error occurred';
                            if (e.message != null) {
                              message = e.message!;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          } catch (e) {
                            print(e);

                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.red,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1))
                            ]),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height - 100,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text(isSignupScreen ? 'or Singup with' : 'or Signin with'),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(155, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Palette.googleColor),
                      label: Text('Google'),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
