import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//stfull
//stless

//Pedidos de venda do produto. PARA MOSTRA A LISTA DOS PEDIDOS.
class PedidosTitle extends StatelessWidget {
  final String pedidosVendas;
  PedidosTitle(this.pedidosVendas);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0), //Para ficar simetrico
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          //O StreamBuilder ficando olhando o tempo todo no banco de dados para ver se tem alguma alteração.
          stream: Firestore.instance
              .collection("orders")
              .document(pedidosVendas)
              .snapshots(), //Atualizando pedido especifico
          builder: (context, snapshot) {
            if (!snapshot.hasData) //Se ainda não contem nenhum dados
            {
              return Center(
                child:
                    CircularProgressIndicator(), //Mostra um circulo para significar que está carregando.
              );
            } else {
              int status =
                  snapshot.data['status']; //Pegando o status do banco de dados.
              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, //Os pedidos ficaram a esquerda
                children: <Widget>[
                  Text("Código do pedido: ${snapshot.data.documentID}",
                      style: TextStyle(
                          fontWeight:
                              FontWeight.bold //Colocando texto em negrito;
                          )),
                  SizedBox(height: 4.0,), //Espaçamento
                  Text(_mostraResumo(snapshot.data)),
                  SizedBox(height: 4.0,), //Espaçamento
                  //Bolinha uma do lado da outra
                   Text("Status do pedido:",
                      style: TextStyle(
                          fontWeight:
                              FontWeight.bold //Colocando texto em negrito;
                          )),
                  SizedBox(height: 4.0,), //Espaçamento
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,//Espaçamento
                    children: <Widget>[
                      _circuloStatus("1", "Preparando", status, 1), //Circulo 1
                      _linha(),
                      _circuloStatus("2", "Transporte", status, 2), //Circulo 2
                      _linha(),
                      _circuloStatus("3", "Entregar", status, 3), //Circulo 3
                      _linha()

                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _mostraResumo(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";
    for (LinkedHashMap produto
        in snapshot.data['produtos']) //Pegar todos os pedidos;
    {
      text +=
          "${produto["quantidade"]} x ${produto["product"]["titulo"]} R\$ ${produto["product"]["preco"].toStringAsFixed(2)})\n";
    }
    text +=
        "Total: R\$ ${snapshot.data["total"].toStringAsFixed(2)}"; //Pegar o total dos pedidos.
    return text;
  }

  Widget _circuloStatus(String titulo, String subtitulo, int status,
      int thisStatus) //Mostrando o status.
  {
    Color backColor; //Cores do status, verde, cinza ou azul
    Widget child; //Stus do circulo

    if (status < thisStatus) //Isso faz que as bolinha 2 e 3 fiquem cinza.
    {
      backColor = Colors.grey[500];
      child = Text(
        titulo,
        style: TextStyle(color: Colors.white),
      );
    } else if (status ==
        thisStatus) //Isso significa que o status e igual a status do pedido.
    {
      backColor = Colors.blue;
      child = Stack(alignment: Alignment.center, //O valores no centro
          children: <Widget>[
            Text(
              titulo,
              style: TextStyle(color: Colors.white),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ) //Cor do circulo branco girando
          ]);
    } else //Se o processo já foi finalizado
    {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }
    //Criação dos status;
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitulo),
      ],
    );
  }

  Widget _linha() {
    return Container(
      height: 1.0,
      width: 4.0,
      color: Colors.grey[500],
    );
  }
}
