import 'package:flutter/material.dart';

//stfull
//stless
class DrawerTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;//Controlar de trocar de paginas
  final int page;//Numeração das paginas

  DrawerTitle(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () //Função que faz com que seja possivel clickar no botão
        {
          Navigator.of(context).pop();//Fechar pagina anterior. PILHA DE PAGINAS É CRIADA.
            controller.jumpToPage(page);//Indo para outra pagina
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: controller.page.round() == page ?//Caso for a pagina ele vai colocar a cor principal
                Theme.of(context).primaryColor : Colors.grey[700],//Se não for a pagina selecionada fica com cinza
              ),
              SizedBox(width: 32.0,),//Espaçamento
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page ?//Caso for a pagina ele vai colocar a cor principal
                Theme.of(context).primaryColor : Colors.grey[700],//Se não for a pagina selecionada fica com cinza
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
