import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teste2/models/user_models.dart';
import 'package:teste2/screens/CriarConta_Screen.dart';

//stfull
//stless

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
//Função de login
class _LoginScreenState extends State<LoginScreen> {
 //Os _ siginifcar que usaremos apenas aqui essa variaveis como se fosse privada.

  final _emailController = TextEditingController();//Pegando o email do usuario;
  final _senhaController = TextEditingController();//Pegando o senha do usuario;

  final _formulario = GlobalKey<FormState>(); //Definimos o formulario
  final _scaffold = GlobalKey<ScaffoldState>(); //Definimos um scaffold para aparecer que for criado o usuario com sucesso ou não;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CADASTRAR",
                style: TextStyle(fontSize: 15.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    //Substituir a tela de entra com a de criar conta
                    MaterialPageRoute(
                        builder: (context) =>
                            SignScreen()) //Indo para pagina de criação da conta
                    );
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UsuarioModel>(
          builder: (context, child, model) {
            if(model.iscarregando)//Se estiver carregando os dados do usuario espera com anuimação de um circulo
              return Center(child: CircularProgressIndicator(),);//Definindo o circulo;
            return Form(
              key: _formulario,
              //O formulario tem a função de validar o seus campos.
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress, //Aparecer o email
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "Email invalido";
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
                  Align(
                    //Alinhamento do botão esquecir a senha
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if(_emailController.text.isEmpty) 
                        {
                      _scaffold.currentState.showSnackBar(
                              //Barra que vai aparecer depois de criar o usuario com sucesso.
                              SnackBar(
                            content: Text("Insira seu e-mail para recuperar senha"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          ));
                        }
                        else
                        {
                          model.recuperSenhas(_emailController.text);
                            _scaffold.currentState.showSnackBar(
                              //Barra que vai aparecer depois de criar o usuario com sucesso.
                              SnackBar(
                            content: Text("Confira seu email"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 3),
                          ));
                        }   
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero, //Tirando o campo em branco.
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ), //Espaçamento para o botão entra
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      //Botão entrar
                      child: Text(
                        "Entar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color:
                          Theme.of(context).primaryColor, //Cor primaria do app
                      onPressed: () {
                        if (_formulario.currentState.validate()) //Estamos pedido o validador avaliar os campos do usuario
                        {
                         
                        }
                         model.sigIn(
                          email: _emailController.text, 
                          pass: _senhaController.text, 
                          onSuccess: _sucesso, 
                          onFail: _failed
                          );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
        );
  }
 void _sucesso() {
    Navigator.of(context).pop();//Sair da tela de login e para tela inicial
  }

  void _failed() {
    _scaffold.currentState.showSnackBar(
        //Barra que vai aparecer depois de criar o usuario com sucesso.
        SnackBar(
      content: Text("Erro ao logar com usuario, SENHA ou EMAIL invalidos"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }
}