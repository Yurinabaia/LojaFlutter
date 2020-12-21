import 'package:cloud_firestore/cloud_firestore.dart';

//Essa classe vai busca os produtos do banco de dados.
class ProdutoDatas
{
  String categoria;
  String id;
  String titulo;
  String descricao;
  double preco;
  List img;
  List prescricao;

  ProdutoDatas.fromDocuments(DocumentSnapshot snapshot) //Buscando do banco de dados.
  {
    id = snapshot.documentID;
    titulo = snapshot.data['titulo'];
    descricao = snapshot.data['descricao'];
    preco = snapshot.data['preco'] + 0.0;
    img = snapshot.data['img'];
    prescricao = snapshot.data['prescricao'];

  }
  //Resumo do pedido
  Map<String, dynamic> toResumoProduto() 
  {
    return 
    {
      "titulo": titulo,
      "descricao": descricao,
      "preco": preco
    };
  }
}