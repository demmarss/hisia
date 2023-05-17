import 'package:flutter/material.dart';
import 'package:hisia/entities/user.dart';
import 'dart:developer' as developer;


import '../isar_services.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TextEditingController _email ;
  late TextEditingController _password ;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _clear() {
    _email.clear();
    _password.clear();
  }

  var srv = IsarService();

  void signup() async {
    var inputEmail = _email.value.text;
    var inputPassword = _password.value.text;

    final user = User()
      ..email = inputEmail
      ..password = inputPassword
      ..createdAt = DateTime.now();

    // for( var i = 2 ; i < 21; i++ ) {
    //   final bool isDelete = await srv.deleteUser(i);
    //   developer.log('Deleted $i => $isDelete', name: 'user.id');
    // }

    final int id = await srv.saveUser(user);
    developer.log('Created user with id $id', name: 'user.id');

    _clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Account '),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 50),
                //logo
                const Text('Welcome',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.red

                  ),
                ),

                const SizedBox(height: 45),
                //slogan
                const Text('Hi.Sia',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                      color: Colors.blueAccent

                  ),
                ),


                const SizedBox(height: 5),

                Container(
                  // width: 105,
                  child: const Center(
                    child: Text('Login or Create New Account to continue',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.lightBlue
                      ),
                    ),
                  )
                ),

                // const Text('Login or Create New Account to continue',
                //   style: TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.normal,
                //       color: Colors.lightBlue
                //
                //   ),
                // ),

                const SizedBox(height: 25),
                //login text field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email'
                    ),
                    onSubmitted: (String value) async {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thanks!'),
                            content: Text(
                                'You typed "$value", which has length ${value.characters.length}.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                //password text field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password'
                    ),
                  ),
                ),
                //sign text field


                const SizedBox(height: 10),
                //forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password',
                      style: TextStyle(
                        color: Colors.grey[700]
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

            GestureDetector(
              onTap: signup,
              child:  Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: Text("Sign Up", style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)),
              ),
            ),
                const SizedBox(height: 50),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 10),
                    Text("Login", style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold
                    ),),
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
