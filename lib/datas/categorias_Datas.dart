import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste2/datas/produtos_Datas.dart';
import 'package:teste2/Title/produtos_title.dart';


//stfull
//stless
class CategoriasDatas extends StatelessWidget {
  //Função responsavel pela tela dos produtos.
  final DocumentSnapshot snapshot; //Dados gravados usando o snapshot.

  CategoriasDatas(this.snapshot);
  @override
  Widget build(BuildContext context) {
    //Função abaixo faz a possibilidade de mudar de grid para lista.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["titulo"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ), //Botão do grid
                Tab(
                  icon: Icon(Icons.list),
                ) //Botão de lista
              ],
            ),
          ),
          //A difereça entre QuerySnapshot e DocumentsSnapshot
          //São que Query é um conjunto de dados do banco
          //Já o Documents Sera de apenas um dado do banco que sera buscado.
          body: FutureBuilder<QuerySnapshot>(
            //O snapshot.documentID são as categorias dos produtos.

            future: Firestore.instance
                .collection("produtos")
                .document(snapshot.documentID)
                .collection("itens")
                .getDocuments(), //Pegando todos os produtos da categoria especificar.
            builder: (context, snapshot) {
              if (!snapshot.hasData) //Se ainda não contem nenhum dados
              {
                return Center(
                  child: CircularProgressIndicator(),
                ); //Animação de um circulo esperando os dados serem carregados do Banco
              } else
                return TabBarView(
                  physics:
                      NeverScrollableScrollPhysics(), //Isso faz com que fique bloqueado de arrasta para lado, apenas com codigo posso arrasta para o lado agora.

                  children: [
                    GridView.builder(
                        //Carregar todos os produtos de forma que sua tela não fique pesada.
                        padding: EdgeInsets.all(
                            4.0), //Espaçamento para os itens não ficarem colados.
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //Isso definir os espaçamentos dos produtos.
                          crossAxisCount: 2, //Quantidade de imagens em uma linha na tela
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: snapshot.data.documents
                            .length, //Pegando a quantidade de produtos que temos para ser apresentado
                        itemBuilder: (context, index) {
                          return ProdutoTitle("grid", ProdutoDatas.fromDocuments(snapshot.data.documents[index]));
                          //O return acima está pegando o objeto ProdutoDatas, esse objeto vem do banco de dados.
                          //Com esse objeto ficar mais facil trocar de banco de dados depois.
                        }
                        ),
                      ListView.builder(
                        padding: EdgeInsets.all(4.0), //Espaçamento para os itens não ficarem colados.
                        itemCount: snapshot.data.documents
                            .length, //Pegando a quantidade de produtos que temos para ser apresentado
                        itemBuilder: (context, index) {
                          return ProdutoTitle("list", ProdutoDatas.fromDocuments(snapshot.data.documents[index]));
                          //O return acima está pegando o objeto ProdutoDatas, esse objeto vem do banco de dados.
                          //Com esse objeto ficar mais facil trocar de banco de dados depois.
                        }
                      )
                  ],
                );
            },
          )),
    );
  }
}
