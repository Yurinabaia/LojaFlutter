import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste2/datas/carrinhoProdutos_Datas.dart';
import 'package:teste2/datas/produtos_Datas.dart';
import 'package:teste2/models/carrinho_models.dart';
//stfull
//stless

//Informaçoes do produto para o carrinho
class CarrinhoTitle extends StatelessWidget {
  final CarrinhoDatas carrinhoDatas;
  CarrinhoTitle(this.carrinhoDatas);
  @override
  Widget build(BuildContext context) {
    //Mostrando o card dos produtos do carrinho
    Widget _buldContet() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,//Alinha
        children: <Widget>[
          //Imagem
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              carrinhoDatas
                  .produtoDatas.img[0], //Acessando as imagens no banco de dados
              fit: BoxFit.cover, //Ocupar toda a tela com a imagem
            ),
          ),
          //Espaçamento em torno da imagem
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,//Alinhando para esquerda
                mainAxisAlignment: MainAxisAlignment.spaceBetween,//Espaçamento
                children: <Widget>[
                //Texto das imagens
                Text(carrinhoDatas.produtoDatas.titulo,//Buscando o nome do produto
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                ), 
                Text(carrinhoDatas.prescri, //Buscando a prescrição do produto
                style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text("R\$ ${carrinhoDatas.produtoDatas.preco.toStringAsFixed(2)}",
                style: TextStyle(
                  color:Theme.of(context).primaryColor,//Cor primaria do texto
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                  ),
                  ),
                  //Produtos soma ou diminuir quantidade.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,//Espaçamento
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.remove),
                      color:Theme.of(context).primaryColor,//Cor primaria do texto
                      onPressed: carrinhoDatas.quantidade >1 ? () //Diminuir produtos.
                      {
                          CarrinhoModel.of(context).removerProduto(carrinhoDatas);
                      } : null,
                      ),
                      Text(carrinhoDatas.quantidade.toString()),
                      IconButton(icon: Icon(Icons.add),
                      color:Theme.of(context).primaryColor,//Cor primaria do texto
                      onPressed: () //Aumentar  produtos.
                      {
                          CarrinhoModel.of(context).adcionarProduto(carrinhoDatas);
                      },
                      ),
                      FlatButton(child: Text("Remover"),
                      textColor: Colors.grey[500],
                      onPressed: () //Remover produto do carrinho
                      {
                          CarrinhoModel.of(context).removeCarrinho(carrinhoDatas);
                      },
                      )
                  ],)
              ],),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: carrinhoDatas.produtoDatas == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("produtos")
                    .document(carrinhoDatas.categoria)
                    .collection("itens")
                    .document(carrinhoDatas.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    carrinhoDatas.produtoDatas =
                        ProdutoDatas.fromDocuments(snapshot.data);
                    return _buldContet();
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buldContet());
  }
}
