import 'package:flutter/material.dart';

import '../entities/user.dart';
import '../isar_services.dart';
import 'dart:developer' as developer;


class AccountScreen extends StatefulWidget {
  // const ({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final _formfield = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passToggle = true;
  bool hasNoAccount = false;

  var accountSubmitBtnText = "Log In";
  var accountQuestionBtn = "Sign Up";
  var accountQuestionText = "Don't have an account?";
  var accountErrorText = "";

  var srv = IsarService();

  void updateAccountText() {
      setState(() {
        hasNoAccount = !hasNoAccount;
        accountSubmitBtnText = hasNoAccount ? "Sign Up": "Log In";
        accountQuestionText = hasNoAccount ? "Already have an account?" : "Don't have an account?" ;
        accountQuestionBtn = hasNoAccount ? "Log In": "Sign Up";
      });
      _formfield.currentState?.reset();
      _clearFormData();

  }
  void handleSubmit() async {
    var inputEmail = _emailController.value.text;
    var inputPassword = _passwordController.value.text;
    final user = await srv.findUserByEmail(inputEmail);

    if(user != null && hasNoAccount ) {
      developer.log('Email already registered, please login instead', name: 'email exists');
      setState(() {
        accountErrorText = "Email already registered, please login instead";
      }); // set to dialog box
      displayErrorMessage();
    }
    else if(_formfield.currentState!.validate()) {
      _clearFormData();

      developer.log('Created user $user with id $hasNoAccount', name: 'user');
      if(hasNoAccount && user == null) {
        final user = User()
          ..email = inputEmail
          ..password = inputPassword
          ..createdAt = DateTime.now();

        final int id = await srv.saveUser(user);
        developer.log('Created user with id $id', name: 'user');
      } else {
          // login user here, check password match the user
           if(user?.password == inputPassword) {
             //navigate to home page
             developer.log('User logged in successfully', name: 'login');
           } else {
             developer.log('Invalid credentials, please try again', name: 'login error');
             accountErrorText = "Invalid credentials, please try again";
             // show in dialog box
             displayErrorMessage();
           }
      }
    }
  }
  void _clearFormData() {
      _emailController.clear();
      _passwordController.clear();
  }

  void displayErrorMessage () => showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Account Error!'),
      content: Text( hasNoAccount ?
          'Email already registered, please login' :
          'Invalid credentials, please try again'
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/images/user.png",
                  height: 200,
                  width: 200,),
                const SizedBox(height: 50,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (email) {
                    bool validEmail = RegExp(r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$").hasMatch(email!);

                    if(email.isEmpty){
                      return "Please Enter Email";
                    }
                    else if(!validEmail){
                      return "Please Enter Valid Email";
                    }
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(passToggle ? Icons.visibility: Icons.visibility_off),
                    )
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Please Enter Password";
                    }
                    else if (_passwordController.text.length < 6) {
                      return "Password should be more than 6 characters";
                    }
                  },
                ),
                const SizedBox(height: 60,),
                InkWell(
                  onTap: handleSubmit,
                  // onTap: displayErrorMessage,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child:  Center(
                      child: Text(
                        accountSubmitBtnText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      accountQuestionText,
                      style: const TextStyle(
                        fontSize: 17,
                      ) ,
                    ),
                    TextButton(
                        onPressed: updateAccountText,
                        child: Text(
                          accountQuestionBtn,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
