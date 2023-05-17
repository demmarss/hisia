import 'package:flutter/material.dart';
import 'dart:developer' as developer;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  void signup() async {
    // var inputEmail = _email.value.text;
    // var inputPassword = _password.value.text;
    developer.log('Created user with id', name: 'user.id');
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
                const SizedBox(height: 100),
                GestureDetector(
                  onTap: signup,
                  child:  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child: Text("Request Info", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),)),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: signup,
                  child:  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent[400],
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child: Text("Send Info", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),)),
                  ),
                ),
                //not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
