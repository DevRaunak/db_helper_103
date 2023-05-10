import 'package:flutter/material.dart';
import 'package:my_db_103/main.dart';
import 'package:my_db_103/user_model.dart';

import 'my_db_helper.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Text('Create Account'),
            SizedBox(
              height: 21,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter Email',
                  label: Text('Email'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
              controller: emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill this Blank';
                }
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Enter Pass',
                  label: Text('Password'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
              controller: passController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill this Blank';
                }
              },
            ),
            SizedBox(
              height: 11,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    print('Signin process starts');

                    bool check = await MyDbHelper().SignIn(
                        emailController.text.toString(),
                        passController.text.toString());

                    if (check) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    } else {
                      print('Invalid Credentials');
                    }
                  }
                },
                child: Text('Sign in'))
          ],
        ),
      ),
    );
  }
}
