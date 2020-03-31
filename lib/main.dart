import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora de IMC",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String resultsText = "Aguardando dados...";
  String _infoText = "";
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  void _refresh() {
    _weightController.text = "";
    _heightController.text = "";
    setState(() {
      resultsText = "Aguardando dados...";
      _infoText = "";
      _keyForm = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;
    double imc = (weight / (height * height));
    setState(() {
      resultsText = "IMC = ${imc.toStringAsPrecision(3)}";
      if (imc < 18.5) {
        _infoText = "Abaixo do peso";
      } else if (imc < 24.9) {
        _infoText = "Peso normal";
      } else if (imc < 29.9) {
        _infoText = "Sobrepeso";
      } else if (imc < 34.9) {
        _infoText = "Obesidade grau I";
      } else if (imc < 39.9) {
        _infoText = "Obesidade grau II";
      } else {
        _infoText = "Obesidade grau III";
      }
    });
  }

  // ignore: missing_return
  String _validate(String value) {
    if (value.isEmpty) {
      return "Preenchimento obrigatório";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _refresh)
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline,
                      color: Colors.deepPurple, size: 120),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    validator: (value) => _validate(value),
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                  ),
                  TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    validator: (value) => _validate(value),
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 10),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_keyForm.currentState.validate()) {
                            _calculate();
                          }
                        },
                        color: Colors.deepPurple,
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    ),
                  ),
                  Text(
                    resultsText,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
