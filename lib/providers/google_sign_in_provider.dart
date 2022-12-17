import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../consts/firebase_const.dart';
import '../screens/tab_bar_screen.dart';
import '../services/methods.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  final googleSignin = GoogleSignIn();
  Future googleSignIn(context) async {

    final googleAcount = await googleSignin.signIn();
    if (googleAcount != null) {
      final googleAuth = await googleAcount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabBarScreen(),
            ),
          );
        } on FirebaseException catch (error) {
          Methods.ErrorDailog(subtitle: '${error.message}', context: context);
        } catch (error) {
          Methods.ErrorDailog(subtitle: '$error', context: context);
        } finally {}
      }
    }
    notifyListeners();
  }
  Future logout() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();

  }
}
