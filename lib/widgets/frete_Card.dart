import 'package:flutter/material.dart';

//stfull
//stless

class FreteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ExpansionTile(
          title: Text(
            "Calcular frete",
            textAlign: TextAlign.center, //Centralizando o texto
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          ),
          leading: Icon(Icons.location_on),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite o seu CEP",
                ),
                initialValue: "", //Caso não tenha frete.
                onFieldSubmitted: (text) {
                 
                },
              ),
            )
          ],
        ));
  }
}