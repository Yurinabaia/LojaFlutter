import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste2/Title/lojas_title.dart';

//stfull
//stless

//Criando a tela das lojas
class LojasTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(//QuerySnapshot é sempre para mais de um documento.
      future: Firestore.instance.collection("loja").getDocuments(),
      builder: (context, snapashot) 
      {
        if (!snapashot.hasData) //Se ainda não contem nenhum dados
              {
                return Center(
                  child: CircularProgressIndicator(),//Mostra um circulo para significar que está carregando.
                );
              }
        else //Mostra lojas
        {
          return ListView(
            children: snapashot.data.documents.map((doc) => LojasTitle(doc)).toList(),//Buscando as lojas
          );
        } 
      },
    );
  }
}