import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//stfull
//stless

//Tela que recebe minhas lojas.
class LojasTitle extends StatelessWidget {
  final DocumentSnapshot snapshot;
  LojasTitle(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, //Imagens esticadas na horizontal
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot.data["img"], //Imagem da minha loja
              fit: BoxFit.cover, //Ocupar todo espaço possivel
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data["titulo"],
                  textAlign: TextAlign.start, //Ficar no lado
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold //Negrito o texto
                      ),
                ),
                Text(
                  snapshot.data["endereco"],
                  textAlign: TextAlign.start, //Ficar no lado
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,//centralizar os botoes a direita
            children: <Widget>[
              FlatButton(
                child: Text("Ver localização"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero, //Sem espaçamento do botão
                onPressed: () {
                  launch("https://www.google.com/maps/search/?api=1&query=${snapshot.data["latitude"]}," 
                  "${snapshot.data["longitude"]}");//Pegando as codernadas para achar local
                },
              ),
              FlatButton(
                child: Text("Ligar"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero, //Sem espaçamento do botão
                onPressed: () {
                launch("tel: ${snapshot.data["tel"]}");//Buscando telefone do banco
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
