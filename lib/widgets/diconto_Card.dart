import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste2/models/carrinho_models.dart';

//stfull
//stless
//Botão do cumpo de desconto.
class DiscontoPrduto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ExpansionTile(
          title: Text(
            "Cupom de desconto",
            textAlign: TextAlign.center, //Centralizando o texto
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          ),
          leading: Icon(Icons.card_giftcard),
          trailing: Icon(Icons.add),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite o codigo do cupom",
                ),
                initialValue: CarrinhoModel.of(context).cupom ??
                    "", //Caso tenha o cupom ele armazenar na variavel cumpo
                onFieldSubmitted: (text) {
                  //Pegando o cumpo
                  Firestore.instance.collection("cupons").document(text.toUpperCase()).get().then((docCupom)
                  {
                    if (docCupom != null) //Se o cumpom existe
                    {
                      CarrinhoModel.of(context).aplicarCupom(text, docCupom.data['percentual']);//aplicando cupom se existe
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Desconto de ${docCupom.data["percentual"]}% aplicado"),
                            backgroundColor: Theme.of(context).primaryColor,//Cor principal definida no app
                      ));
                    } 
                    else 
                    {
                      CarrinhoModel.of(context).aplicarCupom(null, 0);//cupom não existe.
                         Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(
                            "Cumpo não é valido"),
                            backgroundColor:  Colors.redAccent,//Cor principal definida no app
                      ));

                    }
                  }).catchError((e) 
                  {
                     Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(
                            "Cumpo não é valido"),
                            backgroundColor:  Colors.redAccent,),);//Cor de erro
                  }
                  );
                },
              ),
            )
          ],
        ));
  }
}
