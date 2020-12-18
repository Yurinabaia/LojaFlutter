import 'package:flutter/material.dart';
import 'package:teste2/screens/Home_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Loja Virtual',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4,125,141)
      ),
      debugShowCheckedModeBanner:  false,
      home: HomeScreen(),
    );
  }
}
