import 'package:flutter/material.dart';
import 'package:teste2/Tab/home_Tab.dart';
import 'package:teste2/Tab/produtos_tabela.dart';
import 'package:teste2/Tab/meuspedidos_Tab.dart';
import 'package:teste2/Tab/lojas_Tab.dart';
import 'package:teste2/widgets/carrinho_Buttom.dart';
import 'package:teste2/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    //Função abaixo faz com que seja possivel arrasta para ao lado para mudar de pagina
    return PageView(
      controller: _pageController,
      physics:
          NeverScrollableScrollPhysics(), //Isso faz com que fique bloqueado de arrasta para lado, apenas com codigo posso arrasta para o lado agora.
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDraw(_pageController),
          floatingActionButton: CarrinhoBotao(),//botao do carrinho
        ),
        
        Scaffold(//Produtos que iram ser criados as categorias.
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDraw(_pageController),
          body: ProdutosTabela(),
          floatingActionButton: CarrinhoBotao(),//botao do carrinho
        ),
        //Lojas
        Scaffold(
            appBar: AppBar(
              title: Text("Lojas"),
              centerTitle: true,
            ),
        body: LojasTab(),
        drawer: CustomDraw(_pageController),
        ),

        //Meus pedidos
        Scaffold(
            appBar: AppBar(
            title: Text("Meus pedidos"),
            centerTitle: true,
        ),
        body: MeusPedidos(),
        drawer: CustomDraw(_pageController),
        )
      ],
    );
  }
}
