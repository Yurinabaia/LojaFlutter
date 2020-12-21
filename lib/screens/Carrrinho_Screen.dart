import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teste2/Title/carrinho_title.dart';
import 'package:teste2/models/carrinho_models.dart';
import 'package:teste2/models/user_models.dart';
import 'package:teste2/screens/Login_Screen.dart';

//stfull
//stless

//Função abaixo mostra o carrinho de compra do usuario.
class CarrinhoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center, //Centralizando o texto.
            child: ScopedModelDescendant<CarrinhoModel>(
              builder: (context, child, model) {
                int p = model.produtos.length; //Quantidade de produtos;
                return Text(
                  "${p ?? 0} ${p == 1 ? "Item" : "Itens"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CarrinhoModel>(
        builder: (context, child, model) {
          if (model.isCarregandoProduto &&
              UsuarioModel.of(context)
                  .isLogado()) //Caso o usuario estiver logado e estiver carregando os pedidos do banco
          {
            return Center(
              child: CircularProgressIndicator(),
            ); //Animação de um circulo esperando os dados serem carregados do Banco
          } else if (!UsuarioModel.of(context).isLogado()) //Usuario não logado.
          {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart,
                      size: 80.0, color: Theme.of(context).primaryColor),
                  //Espaçamento
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  //Espaçamento
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    //Botão para fazer o login
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,//Cor primaria para o botão de login
                    onPressed: () //Função anonima
                        {
                      Navigator.of(context).push(
                          //Substituir a tela de entra com a de criar conta
                          MaterialPageRoute(
                              builder: (context) =>
                              LoginScreen()) //Indo para pagina de logar
                          );
                    },
                  )
                ],
              ),
            );
          } else if (model.produtos == null || model.produtos.length == 0) //Caso usuario esteja logado e não tenha produto no carrinho.
          {
            return Center(
              child: Text("Nenhum produto no carrinho!",  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold
              ),
              ),
            );
          }
          else//Caso o usuario esteja logado e tenha produto no carrinho
            return ListView(
              children: <Widget>[
                Column(children: model.produtos.map(
                  (produtos) 
                  {
                      return CarrinhoTitle(produtos);
                  }
                ).toList()
                )
              ],
            );
        },
      ),
    );
  }
}
