import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teste2/datas/carrinhoProdutos_Datas.dart';
import 'package:teste2/models/user_models.dart';
import 'package:flutter/material.dart';

//Class que receber o carrinho do usuario.
class CarrinhoModel extends Model {
  UsuarioModel
      usuario; //Usuario atual, que vai armazenar os produtos do usuario.
  List<CarrinhoDatas> produtos = []; //Uma lista com os produtos.


  String cupom;
  int descontoCumpo = 0;
  static CarrinhoModel of(BuildContext context) => ScopedModel.of<CarrinhoModel>(context); //Acesso a qualquer lugar do app
  CarrinhoModel(this.usuario){
    if(usuario.isLogado())
    _carregarCarrinho();//O _ significar que metodo é privado.
  }

  bool isCarregandoProduto = false;

  void addCarrinho(CarrinhoDatas carrinhoprodutos) //Adicionar ao carrinho
  {
    produtos.add(carrinhoprodutos);//Adicionei um produto

    //Salvando no banco de dados os produtos.
    Firestore.instance.collection("usuarios").document(usuario.firebaseusuario.uid).
    collection("carrinho").add(carrinhoprodutos.toMap()).then((doc) 
    {
        carrinhoprodutos.cid = doc.documentID;//Pegando o id do produto.
    }); 
      notifyListeners();//Notificação para o app que está carregando
  }
  void removeCarrinho(CarrinhoDatas carrinhoprodutos) //Remover do carrinho
  {
    //Deletando produto do carrinho
      Firestore.instance.collection("usuarios").document(usuario.firebaseusuario.uid).
      collection("carrinho").document(carrinhoprodutos.cid).delete();
    
    //Removendo da lista
    produtos.remove(carrinhoprodutos);
    notifyListeners();//Notificação para o app que está carregando
  }
  void removerProduto(CarrinhoDatas carrinhoprodutos) //Remover do carrinho
  {
    carrinhoprodutos.quantidade--;//Decrementando produto
    //Decremento produto no firebase
    Firestore.instance.collection("usuarios").document(usuario.firebaseusuario.uid).
    collection("carrinho").document(carrinhoprodutos.cid).updateData(carrinhoprodutos.toMap());//Sempre que damos um updateData ele atualizar no firebase
    notifyListeners();//Notificação para o app que está carregando
  }
  void adcionarProduto(CarrinhoDatas carrinhoprodutos) 
  {
    carrinhoprodutos.quantidade++;//Adcionando produto
     //Decremento produto no firebase
    Firestore.instance.collection("usuarios").document(usuario.firebaseusuario.uid).
    collection("carrinho").document(carrinhoprodutos.cid).updateData(carrinhoprodutos.toMap());//Sempre que damos um updateData ele atualizar no firebase
    notifyListeners();//Notificação para o app que está carregando
  }

  void _carregarCarrinho() //Carrega os produtos do carrinho
  async{//Todo await tem um async  e vice versa.

    QuerySnapshot snapshot =  await  Firestore.instance.collection("usuarios").document(usuario.firebaseusuario.uid).
    collection("carrinho").getDocuments();//Pegar todos os documentos do carrinho
    produtos = snapshot.documents.map((doc)=> CarrinhoDatas.fromDocuments(doc)).toList();
    notifyListeners();//Notificação para o app que está carregando
  }

  void aplicarCupom(String cupom, int descontoCumpo)//Função que aplicar o cupom
  {
    this.cupom = cupom;//O codigo do cupom
    this.descontoCumpo = descontoCumpo;//O valor do desconto em porcentagem
  }
  double valorSemDesconto() 
  {
    double preco = 0.0;
    for(CarrinhoDatas car in produtos) //Pegar cada um dos meus produtos;
    {
      if(car.produtoDatas != null) //Se estiver carregar os produtos;
      {
        preco += car.quantidade * car.produtoDatas.preco;//Mutiplicando com a quantidade de produtos no carrinho.

      }
    }
    return preco;
  }
  double valorComDesconto() 
  {
    return valorSemDesconto() * descontoCumpo /100;//Aplicando o desconto nos pedidos;
  }
  double valorDaEntregar() 
  {
      return 10.0;
  }
  void atualizarPaginar()//Atualizar pagina de pedidos para mostra os valores da compra 
  {
    notifyListeners();//Notificação para o app que está carregando
  }
}
