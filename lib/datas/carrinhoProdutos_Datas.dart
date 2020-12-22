//Carrinho de compra do usuario.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teste2/datas/produtos_Datas.dart';

class CarrinhoDatas
{
  String cid;
  String categoria;
  String pid;
  int quantidade;
  String prescri;
  ProdutoDatas produtoDatas;//Produtos do carrinho.
  CarrinhoDatas();
//Função que busca os produtos para colocar no carrinho
  CarrinhoDatas.fromDocuments(DocumentSnapshot document) 
  {
    cid = document.documentID;
    categoria = document.data['categorias'];
    pid = document.data['pid'];
    quantidade = document.data['quantidade'];
    prescri = document.data['prescri'];
  }

//Função que retorna os campos do pedido.
  Map<String, dynamic> toMap () 
  {
    return 
    {
      "categorias": categoria,
      "pid": pid,
      "quantidade": quantidade,
      "prescri": prescri,
      "titulo": produtoDatas.titulo,
      "product": produtoDatas.toResumoProduto()//Resumo do pedido 
    };
  }
}