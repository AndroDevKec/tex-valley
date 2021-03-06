import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tex_valley/verify_screen.dart';

import 'constants.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _mail, _pass, _cpass, email, password, _user;

  void signUp(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _mail, password: _pass)
        .catchError((onError) {
      showdialogbox(context, "Account Invalid or already in use");
    }).then((authUser) async {
      if (authUser.user != null) User user = FirebaseAuth.instance.currentUser;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerifyScreen()),
      );
    });
  }

  Future showdialogbox(BuildContext context, String message) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: [
              new FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: new Text("ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/logo2.png',
                      height: height * 0.10,
                      width: width * 0.10,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    appName,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
                Center(
                  child: Text(
                    slogan,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Container(
                    child: Text(
                      "  SIGN UP  ",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigoAccent.withOpacity(0.9),
                            Colors.white,
                          ],
                        ),
                        border: Border(
                            left: BorderSide(
                                color: Colors.green[400], width: 7))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _user = value;
                    },
                    validator: (_user) {
                      if (_user.isEmpty)
                        return "Please Enter Username";
                      else if (_user.length < 5 || _user.length > 15)
                        return "username length is incorrect";
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      labelText: "username",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    onSaved: (value) {
                      _mail = value;
                    },
                    validator: (email) {
                      if (email.isEmpty)
                        return "Please Enter Email";
                      else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) return "Its not a valid email";
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      labelText: "Email Address",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _pass = value;
                    },
                    validator: (password) {
                      if (password.isEmpty)
                        return "Please Enter Password";
                      else if (password.length < 8 || password.length > 15)
                        return "Password length is incorrect";
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _cpass = value;
                    },
                    validator: (password) {
                      if (password.isEmpty)
                        return "Please Enter Confirm Password";
                      else if (password.length < 8 ||
                          password.length > 15 ||
                          _pass != _cpass) return "Both passwords are not same";
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      prefixIcon: Icon(
                        Icons.lock_sharp,
                        color: Colors.green,
                      ),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: height * 0.07,
                    width: width * 0.27,
                    child: FlatButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        formkey.currentState.save();
                        signUp(context);
                      },
                      child: Text(
                        "Sign-up ",
                        style: TextStyle(
                            letterSpacing: 0.1,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account"),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text(
                          "Login Account?",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
