import 'dart:io';
import 'package:calculadoraimc/ui/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "dart:async";
import "package:path_provider/path_provider.dart";
import "package:intl/intl.dart";
import '../main.dart';
import "tela_registros.dart";
import 'dart:convert';
import "package:http/http.dart" as http;

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: Home(),
    );
  }
}


DateTime today = new DateTime.now();
String formattedDate = DateFormat('dd/MM/yyy').format(today);

class _HomeState extends State<Home> {


  @override

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _loadArguments2);
  }

  Future<void> _loadArguments2() async {
    tamanholista = await carregarUsuarios();
    print(tamanholista);
  }

  final TextEditingController controlePeso = new TextEditingController();
  final TextEditingController controleAltura = new TextEditingController();
  final TextEditingController controleNome = new TextEditingController();


  String _result = "";
  double imc = 0;
  String _resultado2 = "";

  Color getColor() {
    if (imc == 0) {
      return Colors.white;
    } else if (imc <= 17.0) {
      return Colors.red;
    } else if (imc > 17.0 && imc <= 18.49) {
      return Color.fromARGB(255, 255, 229, 63);
    } else if (imc > 18.49 && imc <= 24.99) {
      return Colors.lightGreen;
    } else if (imc > 24.99 && imc <= 29.99) {
      return Color.fromARGB(255, 255, 229, 63);
    } else if (imc > 29.99) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  void calcularIMC() {
    double pesoDouble;
    double alturaDouble;
    double quadradoAltura;

    pesoDouble = double.parse(controlePeso.text);
    alturaDouble = double.parse(controleAltura.text);
    quadradoAltura = alturaDouble * alturaDouble;
    imc = pesoDouble / quadradoAltura;

    setState(() {
      if (double.parse(controlePeso.text).toString().isNotEmpty &&
          double.parse(controlePeso.text) > 0.0 &&
          double.parse(controleAltura.text).toString().isNotEmpty &&
          double.parse(controleAltura.text) > 0.0) {
        _result = "IMC = ${imc.toStringAsPrecision(4)}\n\n";
        debugPrint(_result);
      } else {
        debugPrint("Ola");
        _result = "Insira teu peso e altura.";
        _resultado2 = "";
      }

      if (imc <= 17.0) {
        _resultado2 = "Você está muito abaixo do peso ideal.";
      } else if (imc > 17.0 && imc <= 18.49) {
        _resultado2 = "Você está abaixo do peso ideal.";
      } else if (imc > 18.49 && imc <= 24.99) {
        _resultado2 = "Você está no peso ideal.";
      } else if (imc > 24.99 && imc <= 29.99) {
        _resultado2 = "Você está acima do peso ideal.";
      } else if (imc > 29.99) {
        _resultado2 = "Você está com obesidade.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tela_Registros()));
        }
            , icon: Icon(Icons.assignment_outlined))],
        centerTitle: true,
        title: Text("Calculadora IMC"),
        backgroundColor: Colors.lightGreen,
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(                               ///ListView
          padding: const EdgeInsets.all(15.0),
          children: [
            Image.asset(
              "assets/imc.png",
              height: 133.0,
              width: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                margin: const EdgeInsets.all(1.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      // CAIXA DE PESO
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        autofocus: true,
                        cursorColor: Colors.lightGreen,
                        style: TextStyle(color: Colors.lightGreen),
                        controller: controlePeso,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightGreen, width: 3.0)),
                          labelText: "Digite teu peso:",
                          labelStyle: TextStyle(color: Colors.lightGreen),
                          hintText: "Kg",
                          icon: Icon(
                            Icons.restaurant,
                            color: Colors.lightGreen,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightGreen, width: 1.5),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0))),
                        ),
                      ),
                    ),
                    Padding(
                      // CAIXA DE AlTURA
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        cursorColor: Colors.lightGreen,
                        style: TextStyle(color: Colors.lightGreen),
                        controller: controleAltura,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightGreen, width: 3.0)),
                          labelText: "Digite tua altura:",
                          labelStyle: TextStyle(color: Colors.lightGreen),
                          hintText: "M",
                          icon: Icon(
                            Icons.height,
                            color: Colors.lightGreen,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightGreen, width: 1.5),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0))),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.lightGreen)),
                        onPressed: calcularIMC,
                        padding: EdgeInsets.all(10.0),
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        child: Text("Calcular", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          controlePeso.text.isEmpty &&
                                  controleAltura.text.isEmpty
                              ? "Insira teu peso e altura"
                              : _result,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        _resultado2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          backgroundColor: getColor(),
                          shadows: <Shadow>[
                            Shadow(offset: Offset(1.0, 1.0)),
                          ],
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.lightGreen)),
                        onPressed: () => abreMensagemSalvar(context, "lol"),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        child: Text("Salvar", style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    FutureBuilder(
                        future: lerDados(),
                        builder: (BuildContext context, AsyncSnapshot dados) {
                          if (dados.hasData != null) {
                            return Text(
                              "Última gravação: \n"
                              "${dados.data}",
                              style: TextStyle(color: Colors.lightGreen),
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Text("Nada salvo ainda");
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //CAIXA DE DIÁLOGO PARA SALVAR

  abreMensagemSalvar(BuildContext context, String mensagem) {
    var alert = AlertDialog(
        title: Text("Deseja salvar?"),
        content: Text("Digite teu nome"),
        actions: <Widget>[
          Padding(
            // CAIXA DE Nome
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.lightGreen,
              style: TextStyle(color: Colors.lightGreen),
              controller: controleNome,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightGreen, width: 3.0)),
                labelText: "Nome Completo",
                labelStyle: TextStyle(color: Colors.lightGreen),
                hintText: "",
                icon: Icon(
                  Icons.face_sharp,
                  color: Colors.lightGreen,
                ),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightGreen, width: 1.5),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20.0))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Data: $formattedDate",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "IMC: ${imc.toStringAsPrecision(4)}",
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      //botao cancelar
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.redAccent)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(10.0),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        child: Text("Cancelar", style: TextStyle(fontSize: 12)),
                      )),
                  Padding(
                    //botao salvar
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.lightGreen)),
                      onPressed: () {
                        setState(() {
                          gravarDados();
                        });
                        Navigator.pop(context);
                        debugPrint("Dados gravados");
                      },
                      padding: EdgeInsets.all(10.0),
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      child: Text("Salvar", style: TextStyle(fontSize: 12)),
                    ),
                  ), RaisedButton(
                    onPressed: (){
                      setState(() {
                        createUser((tamanholista+1),
                            controleNome.text,
                            controlePeso.text,
                            controleAltura.text,
                            imc.toStringAsPrecision(4),
                            formattedDate);
                      });
                      Navigator.pop(context);
                      debugPrint("Dados gravados");
                    },
                  )
                ],
              ),
            ),
          )
        ]);
    showDialog(context: context, builder: (context) => alert);
  }

//CRIANDO CAMINHO

  Future<String> get _caminhoLocal async {
    final diretorio = await getApplicationDocumentsDirectory();
    return diretorio.path; //home/directory/....
  }

//CRIANDO ARQUIVO
  Future<File> get _arquivoLocal async {
    final caminho = await _caminhoLocal;

    return new File("$caminho/dados.txt");
  }

//GRAVAR DADOS
  Future<File> gravarDados() async {


    final arquivo = await _arquivoLocal;

    String dados = ("Nome: ${controleNome.text}\n"
        "Altura: ${controleAltura.text}\n"
        "Peso: ${controlePeso.text}\n"
        "IMC: ${imc.toStringAsPrecision(4)}\n"
        "Data: ${formattedDate}");

    return arquivo.writeAsString(dados);
  }

  //LER DADOS
  Future<String> lerDados() async {
    try {
      final arquivo = await _arquivoLocal;

      //ler
      return await arquivo.readAsString();
    } catch (e) {
      return "Ainda nao foi salvo nada";
    }
  }

  Future<int> carregarUsuarios() async {
    var data = await Uri.parse("https://calculadora-imc-334311-default-rtdb.firebaseio.com/.json");
    http.Response response = await http.get(data);
    Map<String, dynamic> dados = json.decode(response.body);

    List<User3> users = [];

    dados.forEach((k, v) => users.add(User3(altura: "${dados[k]["altura"]}",
        peso: "${dados[k]["peso"]}",
        imc: "${dados[k]["imc"]}",
        data: "${dados[k]["imc"]}",
        nome: "${dados[k]["nome"]}",
        id: "${dados[k]["id"]}")));

    return dados.length;
  }
}
