import 'package:flutter/material.dart';
import 'package:teste2/screens/Carrrinho_Screen.dart';

//stfull
//stless
class CarrinhoBotao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white),
      onPressed: () 
      {
        Navigator.of(context).push(
         MaterialPageRoute(builder: (context)=>CarrinhoScreen())//Indo para a pagina de carrinhos.
        );
      },
      backgroundColor: Theme.of(context).primaryColor,//Cor princial do app
    );
  }
}