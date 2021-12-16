import "package:flutter/material.dart";
import 'package:http/http.dart';
import "dart:async";
import "package:http/http.dart" as http;
import 'dart:convert';



// class URL extends StatefulWidget {
//
//   @override
//   _URLState createState() => _URLState();
// }
//
// class _URLState extends State<URL> {
//
//   var gravacoes = [];
//
//   final url = "https://calculadora-imc-334311-default-rtdb.firebaseio.com/.json";
//
//   void puxarPosts() async{
//    final response = await get(Uri.parse(url));
//    final jsonData = jsonDecode(response.body) as List;
//    debugPrint("$jsonData");
//
//    setState(() {
//      gravacoes = jsonData;
//    });
//
//   }
//
//   void enviarPost() async {
//     final url = "https://calculadora-imc-334311-default-rtdb.firebaseio.com/.json";
//     final response = await post(Uri.parse(url),
//         body: ({"hi": "hello"}));
//
//
//     print(response.body);
//   }
//
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     puxarPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Tela de Registros"),
//         backgroundColor: Colors.green,
//       ),
//       body: ListView.builder(
//         itemCount: gravacoes.length,
//         itemBuilder: (context, i){
//           final post = gravacoes[i];
//           return Text("nome: ${post["nome"]}");
//         },
//       ),
//     );
//   }
// }



// class User {
//   final String id;
//   final String nome;
//   final String peso;
//   final String altura;
//   final String imc;
//   final String data;
//
//   User(this.altura, this.data, this.id, this.imc, this.nome, this.peso);
// }


Future<User3> createUser(int id, String nome, String peso, String altura, String imc, String data) async {
  final response = await http.post(
    Uri.parse('https://calculadora-imc-334311-default-rtdb.firebaseio.com/.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': '${id.toString()}',
      'nome': "$nome",
      'peso': '$peso',
      'altura': '$altura',
      'imc':'$imc',
      'data':'$data'
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User3(id: "1", nome: "Felippe", peso: "lol", altura: "lol", imc: "lol", data: "lol");
  } else {

    throw Exception('Failed to create album.');
  }
}


class User3 {
  final String altura;
  final String data;
  final String id;
  final String imc;
  final String nome;
  final String peso;

  User3({required this.altura, required this.data, required this.id, required this.imc,required this.nome, required this.peso});

  factory User3.fromJson(Map<String, dynamic> json) {
    return User3(
      id: json['id'],
      nome: json['nome'],
      peso: json['peso'],
      altura: json['altura'],
      imc: json['imc'],
        data: json["data"]
    );
  }
}
