import 'package:flutter/material.dart';
import 'package:teste2/Tab/Home_Tab.dart';

class HomeScreen  extends StatelessWidget {
 final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    //Função abaixo faz com que seja possivel arrasta para ao lado para mudar de pagina
    return PageView(
      controller: _pageController,
    physics: NeverScrollableScrollPhysics(),//Isso faz com que fique bloqueado de arrasta para lado, apenas com codigo posso arrasta para o lado agora.
        children: <Widget>[
          HomeTab()

     ],
    );
  }
}