import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:merokinmel_planner/pages/home.dart';

import 'package:merokinmel_planner/pages/tips_calculator.dart';
import 'package:merokinmel_planner/provider/events_block.dart';
import 'package:provider/provider.dart';

class UserLogIn extends StatefulWidget {
  @override
  _UserLogInState createState() => _UserLogInState();
}

class _UserLogInState extends State<UserLogIn> {
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  void logOut() {
    _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final EventBlock eventBlock = Provider.of<EventBlock>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text('Log In'),
                onPressed: () {
                  _handleSignIn().whenComplete(() {
                    eventBlock.setAccountName(user.displayName);
                    eventBlock.setEmail(user.email);
                    eventBlock.setImage(user.photoUrl);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  });
                }),
            RaisedButton(
                child: Text('Log Out'),
                onPressed: () {
                  logOut();
                })
          ],
        ),
      ),
    );
  }
}
