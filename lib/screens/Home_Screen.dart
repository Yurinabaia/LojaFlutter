import 'package:flutter/material.dart';
import 'package:teste2/Tab/Home_Tab.dart';
import 'package:teste2/Tab/produtos_tabela.dart';
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
        ),
        
        Scaffold(//Produtos que iram ser criados as categorias.
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDraw(_pageController),
          body: ProdutosTabela(),
        ),
        Container(color: Colors.yellow),
        Container(color: Colors.blue),
        Container(color: Colors.green),
      ],
    );
  }
}
