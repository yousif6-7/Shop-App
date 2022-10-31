import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/loading_manegar.dart';
import 'package:shop_app/providers/google_sign_in_provider.dart';
import 'package:shop_app/screens/log_in/sign_up_screen.dart';

import '../../consts/firebase_const.dart';
import '../../services/fetch_screen.dart';
import '../../services/methods.dart';
import '../btm_nav_bar.dart';
import 'forget_password.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleProvider = Provider.of<GoogleSignInProvider>(context,listen: false);
    return Scaffold(
      body: LoadingManegar(
        isLoading: isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    padding: EdgeInsets.zero,
                    child: Image.asset('assets/images/clips/login.png'),
                  ),
                  ReusibleText(
                    text: "Welcome to our store",
                    size: 30,
                    textfontWeight: FontWeight.bold,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_passFocusNode),
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onTap: () {},
                          controller: _passwordController,
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            submetonlogin();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Name12345',
                            labelText: "password",
                            prefixIcon: Icon(Icons.lock_rounded),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: _obscureText
                                    ? Icon(Icons.visibility_rounded)
                                    : Icon(Icons.visibility_off_rounded)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "pleas a valid password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        submetonlogin();
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text('LOGIN')),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen(),
                          ));
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text('Forgot password ?'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an acount ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Text('SIGNUP'),
                      ),
                    ],
                  ),
                  ReusibleText(
                    text: 'or',
                    size: 20,
                  ),
                  InkWell(
                    onTap: () {
                     googleProvider.googleSignIn(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/clips/google.png',
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ReusibleText(text: 'Contenu with google'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  void submetonlogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();

      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => FetchScreen()));
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
    }else{
      isLoading = false;

    }
  }
}
