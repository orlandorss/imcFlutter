import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seus dados";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _info = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _info = "Abaixo do peso(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente Acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("IMC CALCULATOR"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          actions: [
            IconButton(onPressed: _resetField, icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_outlined,
                    size: 120,
                    color: Colors.lightGreen,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu peso";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: weightController,
                  ),
                  const Padding(padding: EdgeInsets.all(20.0)),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua altura";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: heightController,
                  ),
                  const Padding(padding: EdgeInsets.all(20.0)),
                  SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightGreen)),
                      child: const Text("Calcular",
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.0)),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20.0)),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
