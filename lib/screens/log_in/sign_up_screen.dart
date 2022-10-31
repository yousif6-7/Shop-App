import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/consts/firebase_const.dart';
import 'package:shop_app/consts/widgets.dart';
import 'package:shop_app/consts/widgets/loading_manegar.dart';
import 'package:shop_app/services/methods.dart';

import '../../services/fetch_screen.dart';
import '../btm_nav_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _addressFocus.dispose();
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
                  icon: Icon(Icons.arrow_back_ios),
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
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_emailFocus),
                          textInputAction: TextInputAction.next,
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_passFocus),
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
                          height: 10,
                        ),
                        TextFormField(
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_addressFocus),
                          controller: _passwordController,
                          focusNode: _passFocus,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.next,
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _addressController,
                          onEditingComplete: () {
                            submetOnSignup();
                          },
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: '23st Place',
                            labelText: "Address",
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "pleas a valid address";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                         TextButton(
                            onPressed: () {
                              submetOnSignup();
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Text('SIGN UP')),
                        Row(
                          children: [
                            ReusibleText(text: "Alredy have an acount ?"),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: Text('LOGIN')),
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
      isLoading =true;
    });
    if (isValid ) {
      _formKey.currentState!.save();

      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());
        final User? user = authInstance.currentUser;
        final _uid =user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id' : _uid,
          'name' : _nameController.text,
          'email':_emailController.text,
          'password': _passwordController.text,
          'Address' : _addressController.text,
          'user_cart' :[],
          'user_wishlist':[],
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FetchScreen()));
      } on FirebaseAuthException catch (error) {
        Methods.ErrorDailog(subtitle: '${error.message}', context: context);
        setState(() {
          isLoading =true;
        });
      }catch (error) {
        Methods.ErrorDailog(subtitle: '$error', context: context);
        setState(() {
          isLoading =true;
          
        });

      }finally{
        setState(() {
          isLoading =false;
        });
      }
    }else{
      isLoading =false;

    }
  }
}
