import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/log_in/log_in_screen.dart';

import '../../consts/firebase_const.dart';
import '../../consts/widgets.dart';
import '../../services/methods.dart';
import '../tab_bar_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkedEmailVerified(),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkedEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      await user!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } on FirebaseAuthException catch (error) {
      Methods.ErrorDailog(subtitle: '${error.message}', context: context);
    } catch (e) {
      Methods.ErrorDailog(subtitle: "Something went wrong", context: context);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const TabBarScreen()
      : Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    text:
                        'A verification E-mail has been send to this Email verify to continu.',
                    textfontWeight: FontWeight.w600,
                  ),
                  TextButton(
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      child: ReusableText(
                        text: 'Resent email',
                      )),
                  TextButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen())),
                      child: ReusableText(
                        text: 'Cansel',
                      ))
                ],
              ),
            ),
          ),
        );
}
