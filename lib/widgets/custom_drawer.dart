import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teste2/Title/drawer_title.dart';
import 'package:teste2/models/user_models.dart';
import 'package:teste2/screens/Login_Screen.dart';

//stless
//stfull

class CustomDraw extends StatelessWidget {
  final PageController pageController;

  CustomDraw(this.pageController);
  @override
  //A função abaixo abre o campo lateral do app.
  //DRAWER É O NOME DO WIDGET CASO QUEIRA PROCURAR.
  Widget build(BuildContext context) {
    //O metodo _buildDegrader criar um degrader para a pagina
    Widget _buildDrawerDegrader() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromARGB(136, 199, 120, 120), //Cor primaria
                Color.fromARGB(136, 199, 120, 52), //Cor secundaria
              ],
                  begin:
                      Alignment.center, //Centralizar os botões da barra lateral
                  end: Alignment
                      .bottomCenter //Centralizar os botões da barra lateral
                  )),
        );
    return Drawer(
      child: Stack(
        //Se você quiser colocar alguma coisa em cima da outra utilizar o Stack
        //Neste caso retornado meu dregrader da barra lateral com Drawer
        children: <Widget>[
          _buildDrawerDegrader(),
          //Lista abaixo são os campos da barra lateral(DRAWER)
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              //Dizeres da barra lateral(DRAWER)
              Container(
                //Espaçamento dos dizeres
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170,
                //Os Dizeres
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 10.0,
                      left: 0.0,
                      child: Image.asset(
                        'imagens/logo.png',
                      ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UsuarioModel>(//ESSE ScopedModelDescendant FAZ COM QUE O USUARIO MODEL CONSIGA RECEBER TODOS OS DADOS DO FORMULARIO
                          builder: (context, child, model) {
                            return Column(
                              //A coluna server para deixa um abaixo do outro.
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Ola, ${!model.isLogado() ? "" : model.userData['nome']}",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight
                                          .bold //Definimos o negrito para o texto
                                      ),
                                ),
                                GestureDetector(
                                  //Definimos o botão, aqui vai identificar caso usuario click no botão
                                  child: Text(
                                    !model.isLogado() ? 
                                    "Entre ou cadastre-se >"//Se não estiver logado apara
                                    : "Sair",//Se estiver logado;
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight
                                            .bold), //Pegando a cor definidar no inicio do app
                                    //fontWeight: FontWeight.bold Definimos o negrito para o texto
                                  ),
                                  onTap: () //Entra acionar o botão
                                      {
                                    if(!model.isLogado())    
                                    Navigator.of(context).push(
                                        //Substituir a tela de entra com a de criar conta
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()) //Indo para pagina de criação da conta
                                        );
                                    else
                                      model.sigOut();
                                  },
                                )
                              ],
                            );
                          },
                        ))
                  ],
                ),
              ),
              Divider(),
              DrawerTitle(Icons.home, "Inicio", pageController, 0),
              DrawerTitle(Icons.list, "Produtos", pageController, 1),
              DrawerTitle(
                  Icons.location_on, "Encontra Loja", pageController, 2),
              DrawerTitle(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
