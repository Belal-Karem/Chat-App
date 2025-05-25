import 'package:belal/constants.dart';
import 'package:belal/helper/Fire_Base_Auth.dart';
import 'package:belal/helper/Show_Snack_Bar.dart';
import 'package:belal/screens/chat_page.dart';
import 'package:belal/screens/registre_page.dart';
import 'package:belal/widgets/custom_button.dart';
import 'package:belal/widgets/custom_form_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  static String id = 'SigninPage';

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String? Email;
  String? Password;
  bool inloding = false;
  bool _isObscure = true;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inloding,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(height: 75),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xffCFDDEA),
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    Email = data;
                  },
                  hinttext: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  obscureText: _isObscure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    color: Colors.white,
                  ),
                  onChanged: (data) {
                    Password = data;
                  },
                  hinttext: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      inloding = true;
                      setState(() {});
                      try {
                        await loginUser(email: Email!, password: Password!);
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: Email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (ex) {
                        showSnackBar(context, 'there was an error');
                        print(ex);
                      }
                      inloding = false;
                      setState(() {});
                    }
                  },
                  text: 'login',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegistrePage.id);
                      },
                      child: Text(
                        'Registre',
                        style: TextStyle(
                          color: Color(0xffC3E7E6),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
