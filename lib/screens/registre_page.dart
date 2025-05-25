import 'package:belal/helper/Fire_Base_Auth.dart';
import 'package:belal/helper/Show_Snack_Bar.dart';
import 'package:belal/screens/chat_page.dart';
import 'package:belal/widgets/custom_button.dart';
import 'package:belal/widgets/custom_form_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrePage extends StatefulWidget {
  RegistrePage({super.key});

  static String id = 'Registrepage';

  @override
  State<RegistrePage> createState() => _RegistrePageState();
}

class _RegistrePageState extends State<RegistrePage> {
  String? email;
  String? password;
  bool inLoding = false;
  bool _isObscure = true;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inLoding,
      child: Scaffold(
        backgroundColor: Color(0xff274460),
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
                        'Registre',
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
                    email = data;
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
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      )),
                  onChanged: (data) {
                    password = data;
                  },
                  hinttext: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      inLoding = true;
                      setState(() {});
                      try {
                        await registreUser(email: email!, password: password!);
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
                        }
                      } catch (ex) {
                        showSnackBar(context, 'there was an error');
                      }
                      inLoding = false;
                      setState(() {});
                    }
                  },
                  text: 'Registre',
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
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
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
