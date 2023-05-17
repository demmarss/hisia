import 'package:flutter/material.dart';
import 'package:hisia/pages/account_page.dart';
import 'dart:developer' as developer;


import 'isar_services.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: AccountScreen(),
    );
  }
}
