import 'package:flutter/material.dart';
import 'package:teste2/datas/produtos_Datas.dart';
import 'package:carousel_pro/carousel_pro.dart';
//stfull
//stless

//Função abaixo abre apenas um produto especifico;

class ProdutoScreen extends StatefulWidget {
  final ProdutoDatas produtos;
  ProdutoScreen(this.produtos);
  @override
  _ProdutoScreen createState() => _ProdutoScreen(produtos);
}

class _ProdutoScreen extends State<ProdutoScreen> {
  final ProdutoDatas produtos;
  String prescri;
  _ProdutoScreen(this.produtos);
  @override
  Widget build(BuildContext context) {
    final Color corprimaria = Theme.of(context)
        .primaryColor; //Definimos uma variavel para a cor primaria, a cor que definimos no main do programa. cor principal

    //Função que vai conter a descrição e imagem do produto. APENAS UM PRODUTO ESPECIFICO.
    return Scaffold(
        appBar: AppBar(
          title: Text(
              produtos.titulo), //Titulo do produto vindo do banco de dados.
          centerTitle: true, //Centralizando o titulo.
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
                //Maneira de visualizar os produtos;
                aspectRatio: 0.9,
                child: Carousel(
                  images: produtos.img.map(
                      (url) //E importante destacar produtos é nosso objeto criado no datas, nele que recebos a imagem
                      {
                    return NetworkImage(
                        url); //Peguei a imagem do banco e transformei em lista
                  }).toList(),
                  dotSize: 4.0, //Botãozinho que ficar nos slides das imagens
                  dotSpacing: 15.0, //Espaçamento do botãozinho
                  dotBgColor: Colors.transparent, //Cor do fundo dos botãozinhos
                  dotColor: corprimaria, //Cor principal do programa
                  autoplay:
                      true, //Isso aqui defir se vc quer que mude as imagens depois que entramos na pagina, significar mudar automaticamente os slides.
                  autoplayDuration: Duration(
                      seconds:
                          5), //A cada 5 segundos os slides iram para o lado.
                )),
            //Espaçamento dos textos na pagina do produto especifico
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, //Ocupar o maxima da pagina com as imagens
                children: <Widget>[
                  Text(
                    produtos.titulo, //Titulo do produto
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0, //Tamnho do titulo
                    ),
                    maxLines:
                        3, //Ocupar apenas 3 linhas mesmo se o titulo for muito grande
                  ),
                  Text(
                    "R\$ ${produtos.preco.toStringAsFixed(2)}", //Ocupar duas casas decimais
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight:
                          FontWeight.bold, //Colocando em negrito o texto.
                      color: corprimaria,
                    ),
                  ),
                  //Espaçamento do preço para a prescricao medidca
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Prescriçao",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 34.0,
                    child: GridView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0), //Um espaçamento na lateral.
                        scrollDirection: Axis
                            .horizontal, //Definimos os espaçamento na horizontal
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //Isso definir os espaçamentos das prescição medica.
                            crossAxisCount: 1,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.5),
                        children: produtos.prescricao.map(
                            //Pegando nossos produtos e chamando o array prescricao do banco de dados
                            (s) {
                          return GestureDetector(
                            onTap: () {
                              setState(
                                  () //O setstate ele atualizar em tempo de execução é o Bading do XAMARIN
                                  {
                                //Armazenando valor na variavel prescri

                                prescri = s;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(
                                      color: prescri == s
                                          ? corprimaria
                                          : Colors.grey[500],
                                      width: 3.0)),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(s),
                            ),
                          );
                        }).toList()),
                  ),
                  //Expasamento para colocar o botão de carrinho
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0, //Tamnho do botão
                    child: RaisedButton(
                      //Definindo o botão
                      onPressed: prescri != null ? 
                      () {} : null,//Se não estiver cliclado ainda na prescição ele deixa desabilitado o botão
                      //Casi click na prescrição ele habilitar o botão;
                      child: Text(
                        "Adicionar ao carrinho",
                        style: TextStyle(
                          fontSize: 18.0
                          ),
                      ),
                      color: corprimaria,//Definimos a cor do botão;
                      textColor: Colors.white,//Cor das letras do botão

                    ),
                  ),
                  //Espaçamento para a descrição do produto
                  SizedBox(height: 16,),
                  Text(
                    "Descrição",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    produtos.descricao,
                    style: TextStyle(
                      fontSize: 16.0
                    )
                  )
                ],
              ),
            )
          ],
        ));
  }
}
