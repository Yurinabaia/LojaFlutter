import 'package:flutter/material.dart';
//Stfull
//stless
class PedidoFinalizado extends StatelessWidget {
  final String idOrder;
  PedidoFinalizado(this.idOrder);
  @override
  Widget build(BuildContext context) {
    //Função que mostra pedido confirmado
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido realizado com sucesso!!!"),
        centerTitle: true,
        ),
        body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,     // ADICIONE ESTE COMANDO!
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//Espaçamento
          children: <Widget>[
            Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,//Cor principal do app
            size: 80.0,
            ),
            Text("Pedido realizado com sucesso!!!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text("O codigo do pedido: $idOrder",
              style: TextStyle(fontSize: 16.0),
            )


          ],
        ),),
    );
  }
}