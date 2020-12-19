import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste2/Title/categorias_title.dart';

//stfull
//stless
class ProdutosTabela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(//Retorna um futuro pois vamos buscar os dados do banco
      future: Firestore.instance.collection("produtos").getDocuments(),//Buscando os dados do banco de dados.
      builder: (context, snapshot) 
      {
        if(!snapshot.hasData)//Se o banco não estiver carregado dados ainda
        return Center(child: CircularProgressIndicator(),);//Ele criar uma animação de um circulo no meio da pagina
        else 
        {
          //Dividindo as categorias dos produtos atraves de uma linha usando a função abaixo.
          var dividesTitle = ListTile.divideTiles(tiles: snapshot.data.documents.map(//Essa função vamos usar em todo programa, ela pegar uma lista de documentos
                (doc) 
                {
                  return CategoriasTitle(doc);
                }
              ).toList(),
          color: Colors.grey[500]).toList();//Cor do divisor e transoformação em lista.
          return ListView(
            children: dividesTitle,//Aqui chamamos a função de divisão de title.
          );
        }
      }
    );
  }
}