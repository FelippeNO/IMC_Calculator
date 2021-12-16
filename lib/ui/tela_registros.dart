import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "dart:async";
import "package:http/http.dart" as http;
import 'dart:convert';
import "url.dart";

class Tela_Registros extends StatefulWidget {
  @override
  _Tela_RegistrosState createState() => _Tela_RegistrosState();
}

class _Tela_RegistrosState extends State<Tela_Registros> {
  bool loading = false;
  List<User3> usuarios = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _loadArguments);
  }

  Future<void> _loadArguments() async {
    usuarios = await getUsers();

    print(usuarios.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Registros"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
          child: loading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(thickness: 0.5, color: Colors.lightGreen,),
                          ListTile(
                            title: Text(usuarios[index].nome.toString()),
                            subtitle: Text(
                                "Peso: ${usuarios[index].peso.toString()}\n"
                                "Altura: ${usuarios[index].altura.toString()}\n"
                                "IMC: ${usuarios[index].imc.toString()}\n"
                                "Data: ${usuarios[index].data.toString()}"),
                            leading: CircleAvatar( radius: 30.0,
                              backgroundColor: Colors.lightGreen,
                              child: Text(
                                  "${usuarios[index].imc.toString()}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )),
    );
  }

  Future<List<User3>> getUsers() async {
    loading = true;
    var data = await Uri.parse(
        "https://calculadora-imc-334311-default-rtdb.firebaseio.com/.json");
    http.Response response = await http.get(data);
    Map<String, dynamic> dados = json.decode(response.body);

    List<User3> users = [];

    dados.forEach((k, v) => users.add(User3(
        altura: "${dados[k]["altura"]}",
        peso: "${dados[k]["peso"]}",
        imc: "${dados[k]["imc"]}",
        data: "${dados[k]["data"]}",
        nome: "${dados[k]["nome"]}",
        id: "${dados[k]["id"]}")));
    print(users);

    debugPrint("${dados.length}");
    debugPrint("${dados}");

    setState(() {
      loading = false;
    });

    return users;
  }
}

//
// child: FutureBuilder(
// future: getUsers(),
// builder: (BuildContext context, AsyncSnapshot snapshot) {
// if (snapshot.data == null) {
// return Container(
// child: Center(
// child: Text("Loading..."),
// ),
// );
// } else {
