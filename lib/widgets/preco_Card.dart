import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teste2/models/carrinho_models.dart';

//stfull
//stless
class CarrinhoPreco extends StatelessWidget {
  
  final VoidCallback compra;
  CarrinhoPreco(this.compra);//Chamando a função de compra do app

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CarrinhoModel>(
          //Refazendo o usuario, sempre que usuario mudar mudar o carrinho
          builder: (context, child, model) {
            
            //Valores que vai aparecer no resumo do pedido;
            double preco = model.valorSemDesconto();
            double desconto = model.valorComDesconto();
            double frete = model.valorDaEntregar();
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, //Ocupar o maximo de espaço
              children: <Widget>[
                Text(
                  "Resumo do pedido: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ), //Espaçamento
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, //Espaçamento
                  children: <Widget>[
                    Text("Valor sem desconto: "),
                    Text("R\$ ${preco.toStringAsFixed(2)}")
                  ],
                ),
                Divider(), //Uma linha para dividir
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, //Espaçamento
                  children: <Widget>[
                    Text("Desconto: "), 
                    
                    desconto > 0 ? Text("R\$ -${desconto.toStringAsFixed(2)}", style: TextStyle(color: Colors.redAccent),) :
                    Text("R\$ ${desconto.toStringAsFixed(2)}",), 
                    ],
                ),
                Divider(), //Uma linha para dividir
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, //Espaçamento
                  children: <Widget>[
                    Text("Valor entregar: "),
                    Text("R\$ ${frete.toStringAsFixed(2)}")
                  ],
                ),
                Divider(), //Uma linha para dividir
                SizedBox(
                  height: 12.0,
                ), //Espaçamento
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, //Espaçamento
                  children: <Widget>[
                    Text(
                      "Valor Total: ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${(preco + frete - desconto).toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0) //Cor principal do app
                      ,
                    )
                  ],
                ),
                SizedBox(height: 12.0,), //Espaçamento
                RaisedButton(child: Text("Finalizar pedido", ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,//Cor princpial do app
                onPressed: compra,

                )
              ],
            );
          },
        ),
      ),
    );
  }
}
