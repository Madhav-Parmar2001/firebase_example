import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FireBase/Firebase_HomePage.dart';

class GoogleLogin extends StatefulWidget {
  @override
  State<GoogleLogin> createState() => GoogleLoginState();
}

class GoogleLoginState extends State<GoogleLogin> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  checklogin2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("islogin2")) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Firebase_HomePage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with google"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Login with google"),
          color: Colors.blue,
          onPressed: () async {

            GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
            GoogleSignInAuthentication googleSignInAuthentication =await googleSignInAccount.authentication;
            AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );
            UserCredential authResult = await _auth.signInWithCredential(credential);
            User _user = authResult.user;

            print("Name : "+_user.displayName);
            print("Email : "+_user.email);
            print("photo : "+_user.photoURL);
            print("Google Key : "+_user.uid);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("islogin2", "yes");
            prefs.setString("Name", _user.displayName);
            prefs.setString("Email", _user.email);

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Firebase_HomePage(),)
            );
          },
        ),
      ),
    );
  }
}


