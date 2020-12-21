//Criando as ações do usuario

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';

//O Model é o objeto que guardo o status de alguma coisa. Neste caso é o do login
class UsuarioModel extends Model {
  //ESTADO ATUAL.
  //Os campos com _ não podem ser usada fora desta classe como se fosse private, sem o _ é public.

  FirebaseAuth _auth = FirebaseAuth.instance;//iSSO AQUI É UM SEGTON

  FirebaseUser firebaseusuario;//Informação dos dados do usuario.
  Map<String, dynamic> userData = Map();//Isso vai guarda todos os dados de cadastro/login que usuario digitar no app 
  bool iscarregando = false;//Carregando pagina
  
  static UsuarioModel of(BuildContext context) => ScopedModel.of<UsuarioModel>(context);//Qualquer lugar que eu chame eu posso chamar.


  @override
    void addListener(listener) {
      // TODO: implement addListener
      super.addListener(listener);
      _deixarUsuarioLogado();
    } 
  //Fazer login depois de cadastra.
  void logar  ({@required Map<String, dynamic> userData, @required String senha,
   @required VoidCallback sucesso,@required VoidCallback faliled }) //As chaves significa que os
   // campos são opcional mas o requider confirma a entrada deste campos, isso ajudar a colocar em qualquer ordem os parametro;
  //Todo await tem um async e vice e versa. esperando carregar.
  {
    iscarregando = true;//carregando
    notifyListeners();//Notificação para o app que está carregando
    print(senha);
    _auth.createUserWithEmailAndPassword(
      email: userData['email'],//Informando o email do usuario cadastrado
      password: senha//senha do usuario
    ).then((user)//Logando com usuario
    async {

       firebaseusuario = user;//Salvando os dados do usuario.
       
      await _saveUsuarioData(userData);//Esperando salvar os dados no Firebase
        sucesso();
        iscarregando = false;//para de carregar.
        notifyListeners();//Notificação para o app que está carregando
    }).catchError((e)//Erro ao cadastra.
    {
        faliled();
        iscarregando = false;//para de carregar.
        notifyListeners();//Notificação para o app que está carregando
    });
  }

//Fazer login atraves do email e senha.
  void sigIn({@required String email, @required String pass,
      @required VoidCallback onSuccess, @required VoidCallback onFail}) async {

    iscarregando = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
      (user) async {
        firebaseusuario = user;

        await _deixarUsuarioLogado();

        onSuccess();
        iscarregando = false;
        notifyListeners();

    }).catchError((e){
      onFail();
      iscarregando = false;
      notifyListeners();
    });

  }



  //Sair da conta
  void sigOut() async {//Todo await tem um async e vice e versa. esperando carregar.
    await _auth.signOut();
    userData = Map();
    firebaseusuario = null;
    notifyListeners();//Notificação para o app que está carregando
  }
  //Mandando o email para usuario redefinir sua senha.
  void recuperSenhas(String uemail) 
  {
    _auth.sendPasswordResetEmail(email: uemail);
  }

  bool isLogado() 
  {
    return firebaseusuario != null;//Se usuario estive logado vai retorna true
  }

  Future<Null> _saveUsuarioData(Map<String, dynamic> userData) //Função que vai guarda os dados do usuario
  async {
      this.userData = userData;
      await Firestore.instance.collection("usuarios").document(firebaseusuario.uid).setData(userData);
      //Salvando os dados no firebase;
  }


 Future<Null> _deixarUsuarioLogado() async 
  {
    if(firebaseusuario == null) //Verificando se não algum usurio logado
      firebaseusuario = await _auth.currentUser();//Pegando usuario logado.
    if(firebaseusuario != null) //Verificando se tem algum usuario logado.
    {
        if(userData['name'] == null)//Se minha lista não conter os dados do usuario
        {
          DocumentSnapshot docUsuario = await 
          Firestore.instance.collection("usuarios").document(firebaseusuario.uid).get();
          //Aqui estou pegando os dados do usuario
          userData = docUsuario.data;
        }
    }
    notifyListeners();//Notificação para o app que está carregando

  }

}
