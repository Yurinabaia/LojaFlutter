
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//stfull
//stless
class CategoriasTitle extends StatelessWidget {
  final DocumentSnapshot snapshot;//As variaveis chamadas snapshot são as que buscamos do banco de dados.

  CategoriasTitle(
      this.snapshot); //Passando os documentos que vai conter os dados dos produtos.
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(//Criado o ciculo do icone dos produtos
        radius: 25.0,//Definimos o raio deste circulo
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data['icon']),//Buscando o icon do banco de dados.
      ),
      title: Text(snapshot.data['titulo']),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () //Definimos o onTap para realizar uma função, o botão 
      {

      },
    );
  }
}
