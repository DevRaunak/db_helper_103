import 'package:flutter/material.dart';
import 'package:my_db_103/my_db_helper.dart';
import 'package:my_db_103/sign_in.dart';
import 'package:my_db_103/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController();
  var genderController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var mobNoController = TextEditingController();

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
                  hintText: 'Enter name',
                  label: Text('Name'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill this Blank';
                }

                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter Gender',
                  label: Text('Gender'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
              controller: genderController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill this Blank';
                }
              },
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
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter Mobile No',
                  label: Text('Mob No'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
              controller: mobNoController,
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

                    int check = await MyDbHelper().SignUp(UserModel(
                        name: nameController.text.toString(),
                        email: emailController.text.toString(),
                        gender: genderController.text.toString(),
                        pass: passController.text.toString(),
                        mobno: mobNoController.text.toString()));

                    if (check > 0) {
                      print('Account Created!!');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ));
                    } else if(check==0){
                      print('Database error!!');
                    } else if(check==-100){
                      print('Email Already Exists!!');
                    }
                  }
                },
                child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
