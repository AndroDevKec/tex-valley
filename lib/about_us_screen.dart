import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("About Us"),
        actions: [
          IconButton(icon: Icon(Icons.account_circle_rounded), onPressed: () {})
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/logo2.png',
            height: height * 0.20,
            width: width * 0.20,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "      Tex-Valley was developed by Janani, Mathiarasi, Mythili and Naishad of KONGU ENGINEERING COLLEGE. ",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "      We created this platform to bring potential buyers across the globe, to interact and finalize the business deals after Tex-Valley meetings with the quality sellers."
            " This app is likely to lead to development long term bussiness relations among themselves.",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "For Further more details Contact us ",
            style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "androdevkec@gmail.com",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "+91 9080418894",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
