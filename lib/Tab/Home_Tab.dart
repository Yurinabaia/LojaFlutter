import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

//stless
//stfull
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //O metodo _buildDegrader criar um degrader para a pagina
    Widget _buildDegrader() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(131, 99, 153, 169),//Cor primaria
            Color.fromARGB(132, 100, 159, 123),//Cor secundaria
            
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(//Se você quiser colocar alguma coisa em cima da outra utilizar o Stack
    //Neste caso estou chamando o meu degrader para a pagina
      children: [
        _buildDegrader(),//Chamando a função do degrader.
        CustomScrollView(//Isso é um scrool view customizado
        //O codigo abaixo serve para mostra o campo novidades que aparecer no app
            slivers: <Widget>[
              SliverAppBar(
                floating: true,//Fluação do meu campo
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text("Novidades"),
                  centerTitle: true,
                ),
              ),
              //A função abaixo carregar as imagens da pagina HOME
              FutureBuilder <QuerySnapshot>(
                  future: Firestore.instance.collection("home").orderBy("poc").getDocuments(),//Buscando do banco de dados as imagens
                  builder: (Context,snapshot) 
                  {
                    if(!snapshot.hasData)//Se as imagens ainda não estiver carregas tenha uma animação de um cirulo
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200,//Aqui o tamanho do campo
                        alignment: Alignment.center,//Aqui defimos o campo ao centro
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),//Aqui definimos o ciruclo
                      ),
                    );
                    else 
                    {
                      return SliverStaggeredGrid.count(//Campo que vai busca as imagens
                        crossAxisCount: 3,//Quantidade de imagens por linha
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        staggeredTiles: snapshot.data.documents.map(//Essa função vamos usar em todo programa, ela pegar uma lista de documentos
                          (doc) 
                          {
                              return StaggeredTile.count(doc.data["x"],doc.data["y"]);
                              //Pegando o X e o Y do banco de dados, que é a dimensão da imagem e transformando em StaggeredTile
                          }
                        ).toList(),//A função acima vai ser transformada em lista
                        children: snapshot.data.documents.map(//Essa função vamos usar em todo programa, ela pegar uma lista de documentos
                          (doc) 
                          {
                            return FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,//Aqui definimos a transparencia
                                image: doc.data["image"],//Aqui estamos buscando a imagem do banco
                                fit: BoxFit.cover,//Ocupar toda pagina possivel com a imagem
                            );
                          }
                        ).toList(),

                      );

                    }
                  }
              )
            ],
        )
      ],

    );//Stack

  }
}