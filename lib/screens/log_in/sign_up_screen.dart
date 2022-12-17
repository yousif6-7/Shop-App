import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/consts/firebase_const.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/loading_manegar.dart';
import 'package:shop_app/screens/log_in/varifecation_secrren.dart';
import 'package:shop_app/services/methods.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManegar(

        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusibleText(
                          text: "Welcome",
                          size: 30,
                          textfontWeight: FontWeight.bold,
                        ),
                        ReusibleText(
                          text: "Sign up to contenue",
                          size: 20,
                          textfontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_emailFocus),
                          textInputAction: TextInputAction.next,
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Full name",
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "pleas enter a valid Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_passFocus),
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(

                          controller: _passwordController,
                          focusNode: _passFocus,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Name12345',
                            labelText: "password",
                            prefixIcon: const Icon(Icons.lock_rounded),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: _obscureText
                                    ? const Icon(Icons.visibility_rounded)
                                    : const Icon(Icons.visibility_off_rounded)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "pleas a valid password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        TextButton(
                            onPressed: () {
                              submetOnSignup();
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: const Text('SIGN UP')),
                        Row(
                          children: [
                            ReusibleText(text: "Alredy have an acount ?"),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: const Text('LOGIN')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool isLoading =false;
  void submetOnSignup() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();

      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());
        final User? user = authInstance.currentUser;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userUid", user!.uid);
        final _uid = user.uid;
        user.updateDisplayName(_nameController.text);
        user.reload();
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'user_cart': [],
          'user_wishlist': [],

        });
        await FirebaseFirestore.instance.collection('orders').doc(_uid).set({
          'orders': [],
        });
        if(!mounted)return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const VerificationScreen()));
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
    } else {
      isLoading = false;
    }
  }
}
