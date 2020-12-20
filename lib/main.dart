import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teste2/models/user_models.dart';
import 'package:teste2/screens/Home_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UsuarioModel>(//Aqui definimos o ScopedModel para ele enteder que queremos o atualização do app
      model: UsuarioModel(),//A classe UsuarioModel vai ter acesso a tudo que estiver aqui
      child: MaterialApp(
      title: 'Aplicativo de Loja Virtual',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4,125,141)//Cor primaria
      ),
      debugShowCheckedModeBanner:  false,
      home: HomeScreen(),
    ),
    );
  }
}
