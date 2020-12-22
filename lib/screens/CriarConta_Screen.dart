import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teste2/models/user_models.dart';

//stfull
//stless

class SignScreen extends StatefulWidget {
  @override
  _SignScreenState createState() => _SignScreenState();
}

//Criando conta.
class _SignScreenState extends State<SignScreen> {
  final _formulario = GlobalKey<FormState>(); //Definimos o formulario
  final _scaffold = GlobalKey<ScaffoldState>(); //Definimos um scaffold para aparecer que for criado o usuario com sucesso ou não;

  //Dados do formulario.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          title: Text("Criando Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UsuarioModel>(
            //ESSE ScopedModelDescendant FAZ COM QUE O USUARIO MODEL CONSIGA RECEBER TODOS OS DADOS DO FORMULARIO
            builder: (context, child, model) {
          if (model
              .iscarregando) //Se estiver carregando os dados do usuario espera com anuimação de um circulo
            return Center(
              child: CircularProgressIndicator(),
            ); //Definição do circulo
          return Form(
            key: _formulario,
            //O formulario tem a função de validar o seus campos.
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    hintText: "Nome",
                  ),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty) return "Nome Invalido";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ), //Espaçamento do formulario
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress, //Aparecer o email
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "Email invalido";
                  },
                ),
                TextFormField(
                  controller: _enderecoController,
                  decoration: InputDecoration(
                    hintText: "Endereço",
                  ),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty) return "Endereço invalido";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ), //Espaçamento do formulario
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText:
                      true, //Fazendo com que o usuario não veja sua senha
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha invalidar";
                  },
                ),

                SizedBox(
                  height: 16.0,
                ), //Espaçamento para o botão entra
                SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      //Botão entrar
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color:
                          Theme.of(context).primaryColor, //Cor primaria do app
                      onPressed: () {
                        if (_formulario.currentState
                            .validate()) //Estamos pedido o validador avaliar os campos do usuario
                        {
                          //O map abaixo são os dados do usuario, a senha não é salva neste map pois não salvamos senha diretamente no FIREBASE
                          Map<String, dynamic> userData = {
                            //Não esquecer do .text no final
                            "nome": _nomeController.text, 
                            "email": _emailController.text,
                            "enderco": _enderecoController.text
                          };
                          model.logar(
                              userData: userData,
                              senha: _senhaController.text,
                              sucesso: _sucesso,
                              faliled: _faliled
                              );
                        }
                      },
                    )
                    ),
              ],
            ),
          );
        }));
  }

  void _sucesso() {
    _scaffold.currentState.showSnackBar(
        //Barra que vai aparecer depois de criar o usuario com sucesso.
        SnackBar(
      content: Text("Usuario criado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context)
          .pop(); //Sair da tela de cadastro e para tela inicial
    });
  }

  void _faliled() {
    _scaffold.currentState.showSnackBar(
        //Barra que vai aparecer se o usuario não conseguir logar.
        SnackBar(
      content: Text("Erro ao criar o usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
