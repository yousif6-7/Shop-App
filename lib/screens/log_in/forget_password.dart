import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/consts/widgets/loading_manegar.dart';
import 'package:shop_app/services/methods.dart';

import '../../consts/firebase_const.dart';
import '../../consts/widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManegar(

        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusibleText(
                      text: "Welcome",
                      size: 30,
                      textfontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "aaaaa@gmail.com",
                        labelText: "email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return "pleas enter a valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        forgotPass(
                        );
                      },
                      child: Text('Reset password'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future forgotPass()async {
    if(_emailController.text.isEmpty || !_emailController.text.contains('@')){
      Methods.ErrorDailog(subtitle: "Pleas enter a valid email", context: context);
    }else{
      setState(() {
        isLoading= true;
      });
      try {
        await authInstance.sendPasswordResetEmail(email: _emailController.text.toLowerCase());
      } on FirebaseAuthException catch (error) {
        Methods.ErrorDailog(subtitle: '${error.message}', context: context);
        setState(() {
          isLoading = true;
        });
      } catch (error) {
        Methods.ErrorDailog(subtitle: '$error', context: context);
        setState(() {
          isLoading = true;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
