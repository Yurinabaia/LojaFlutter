import 'package:flutter/material.dart';
import 'package:teste2/datas/produtos_Datas.dart';
import 'package:teste2/screens/Produtos_Screen.dart';

//stfull
//stless
class ProdutoTitle extends StatelessWidget {
  final String tipo;
  final ProdutoDatas protutos;
  ProdutoTitle(this.tipo, this.protutos);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () //Função que vai ser executada assim que o usuario clickar nela.
      { 
          Navigator.of(context).push(//Navegando para proxima pagina, todo Navigator é uma pilha de paginas
            MaterialPageRoute(builder: (context)=>ProdutoScreen(protutos))//Mandando os dados para pagina dos produtos;
            
          );
      },  
      //O InkWell é parecido com gestordetection a diferença é que o inkWell faz uma animação quando tocar ele;
      child: Card(
        child: tipo == "grid"
            ? Column(
                //Se o o tipo passador for um grid colocamos uma coluna
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, //Para colocar as imagens esticadas
                mainAxisAlignment:
                    MainAxisAlignment.start, //Ficar no inicio do tela
                children: <Widget>[
                  AspectRatio(
                    aspectRatio:
                        0.8, //Definimos um aspector para todos os dispositivos.
                    child: Image.network(
                        //Trazendo as imagens dos produtos
                        protutos.img[0],
                        fit: BoxFit.cover //Ocupar todo o espaço da tela.
                        ),
                  ),
                  //O texto com preco dos produtos.
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.all(0.8), //Espaçamento entre os textos.
                      child: Column(
                        children: <Widget>[
                          Text(
                            protutos.titulo,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "R\$ ${protutos.preco.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Row(
                //Se o tipo for passador for uma list colocamos uma linha
                //Os campos usando Flexible faz com que cada lada tenha o mesma valor idependente do dispositivo
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      //Trazendo as imagens dos produtos
                      protutos.img[0],
                      fit: BoxFit.cover, //Ocupar todo o espaço da tela.
                      height: 250,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.all(0.9), //Espaçamento entre os textos.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,//Deixa o texto na lateral.
                        children: <Widget>[
                          Text(
                            protutos.titulo,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "R\$ ${protutos.preco.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,//Tamnho do texto.
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
