import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tex_valley/constants.dart';
import 'package:tex_valley/login_screen.dart';
import 'package:tex_valley/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _mail;
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
                      "  Reset Password  ",
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
                    onFieldSubmitted: _onchanged,
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
                      labelText: "Enter your E-mail Address ",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Text("Return to login page",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 16))),
                ),
                Center(
                  child: SizedBox(
                    height: height * 0.07,
                    width: width * 0.50,
                    child: FlatButton(
                      color: Colors.green[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _mail);
                        showdialogbox(context,
                            "Verification password reset link is send to your email. click link to change password");

                        //Navigator.of(context).pop();
                      },
                      child: Text(
                        "send email verification",
                        style: TextStyle(
                            letterSpacing: 0.1,
                            fontSize: 24,
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

  void _onchanged(String value) {
    setState(() {
      _mail = value;
    });
  }
}
