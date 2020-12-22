import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste2/Title/pedidos_title.dart';
import 'package:teste2/models/user_models.dart';
import 'package:teste2/screens/Login_Screen.dart';

//stless
//stfull


//Pagina que vai acompanhar os pedidos do usuario.
class MeusPedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(UsuarioModel.of(context).isLogado())//se eu estiver logado
    {
        String uid = UsuarioModel.of(context).firebaseusuario.uid;//Buscando o ID do usuario.
        return FutureBuilder<QuerySnapshot> 
        (
          future: Firestore.instance.collection("usuarios").document(uid).collection("orders").getDocuments(),//Buscando os produtos do usuario especifico
          builder: (context, snapshot) 
          {
            if (!snapshot.hasData) //Se ainda não contem nenhum dados
              {
                return Center(
                  child: CircularProgressIndicator(),//Mostra um circulo para significar que está carregando.
                );
              }
              else 
              {
                return ListView(
                  children: snapshot.data.documents.map((doc)=>PedidosTitle(doc.documentID)).toList()
                );
              }
          },
        );
    } else //Se não estiver logado mostra a tela dele entra no app.
    {
      Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.view_list,
                      size: 80.0, color: Theme.of(context).primaryColor),
                  //Espaçamento
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para acomanha seu pedido",
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
    }
  }
}