import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dent_app/auth/GoogleSignIN.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui_myapp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: logIn(),);
  }
}


class logIn extends StatefulWidget {
  @override
  _logInState createState() => _logInState();
}

class _logInState extends State<logIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences _preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    _preferences = await SharedPreferences.getInstance();
    isLogedin = await _googleSignIn.isSignedIn();
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSignin() async {
    _preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    print("signed in " + user.displayName);

    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance.collection("users").document(user.uid).setData({
          "id": user.uid,
          "username": user.displayName,
          "profilepic": user.photoUrl
        });
        await _preferences.setString("id", user.uid);
        await _preferences.setString("username", user.displayName);
        await _preferences.setString("photourl", user.displayName);
      } else {
        await _preferences.setString("id", documents[0]['id']);
        await _preferences.setString("username", documents[0]['username']);
        await _preferences.setString("photourl", documents[0]['photourl']);
      }

      Fluttertoast.showToast(msg: "Wellcome ${user.displayName}");

      setState(() {
        loading = false;
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      Fluttertoast.showToast(msg: "Login failed :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: Image(image: AssetImage('assets/ff.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "DentApp ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "your gate to all the new about dentists stuffs  cases materails , tools , labs ",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        color: Colors.teal,
                        height: 70,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 35,
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: MaterialButton(
                                      onPressed: () {
                                        handleSignin();
                                      }
                                      ,
                                      child: Text(
                                        "Log in",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.teal.shade700,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: loading ?? true,
                                    child: Center(
                                      child: Container(
                                        color: Colors.white.withOpacity(.7),
                                        child: CircularProgressIndicator(

                                          valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              Colors.teal),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "or SignUp",
                                style:
                                TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    )
    ;
  }
}
