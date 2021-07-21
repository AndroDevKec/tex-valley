import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tex_valley/constants.dart';
import 'package:tex_valley/main.dart';
import 'package:tex_valley/password_reset.dart';
import 'package:tex_valley/profilescreen.dart';
import 'package:tex_valley/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _mail, _pass;
  void signIn(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _mail, password: _pass)
        .catchError((onError) {
      showdialogbox(context, "No account found");
    }).then((authUser) {
      if (authUser.user != null)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      //ieBUkCerAuWIUKML1FinjjULShu1
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
                      height: height * 0.45,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height * 0.47,
                      width: width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              stops: [0.3, 0.9],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.white])),
                      // color: Colors.white.withOpacity(0.3),
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
                      "  LOGIN  ",
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
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    onSaved: (value) {
                      _mail = value;
                    },
                    validator: (email) {
                      if (email.isEmpty)
                        return "Pleas Enter Email";
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
                      labelText: "Email Address or Phone number",
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
                        return "Pleas Enter Email";
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
                  padding: const EdgeInsets.only(left: 250),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordReset()),
                        );
                      },
                      child: Text("Forget Password?",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 16))),
                ),
                Center(
                  child: SizedBox(
                    height: height * 0.07,
                    width: width * 0.34,
                    child: FlatButton(
                      color: Colors.green[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          signIn(context);
                        }
                      },
                      child: Text(
                        "Login to account",
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
                    Text("Don't have an account?"),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          "Create Account..",
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
