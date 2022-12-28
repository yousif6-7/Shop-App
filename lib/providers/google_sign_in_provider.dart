import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../consts/firebase_const.dart';
import '../screens/btm_nav_bar.dart';
import '../services/methods.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAcount = await googleSignIn.signIn();
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
              builder: (context) => const BtmNavBarScreen(),
            ),
          );
        } on FirebaseException catch (error) {
          Methods.ErrorDailog(subtitle: '${error.message}', context: context);
        } catch (error) {
          Methods.ErrorDailog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  notifyListeners();
}
