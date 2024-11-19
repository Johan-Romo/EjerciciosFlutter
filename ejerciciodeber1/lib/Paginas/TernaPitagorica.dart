import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
class TernaPitagorica extends StatefulWidget {
  const TernaPitagorica({super.key});

  @override
  State<TernaPitagorica> createState() => _TernaPitagoricaState();
}

class _TernaPitagoricaState extends State<TernaPitagorica> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  final TextEditingController _controllerC = TextEditingController();
  String _resultado = '';
  bool? _esTernaPitagorica;

  void _verificarTerna() {
    if (_controllerA.text.isEmpty ||
        _controllerB.text.isEmpty ||
        _controllerC.text.isEmpty) {
      setState(() {
        _resultado = 'Por favor, ingrese todos los números';
        _esTernaPitagorica = null;
      });
      return;
    }


    int a = int.parse(_controllerA.text);
    int b = int.parse(_controllerB.text);
    int c = int.parse(_controllerC.text);


    int a2 = a * a;
    int b2 = b * b;
    int c2 = c * c;


    bool esTerna = (a2 + b2 == c2) || (a2 + c2 == b2) || (b2 + c2 == a2);

    setState(() {
      if (esTerna) {
        _resultado = '¡Es una terna pitagórica!';

        if (a2 + b2 == c2) {
          _resultado += '\n$a² + $b² = $c²\n($a2 + $b2 = $c2)';
        } else if (a2 + c2 == b2) {
          _resultado += '\n$a² + $c² = $b²\n($a2 + $c2 = $b2)';
        } else {
          _resultado += '\n$b² + $c² = $a²\n($b2 + $c2 = $a2)';
        }
      } else {
        _resultado = 'No es una terna pitagórica';
      }
      _esTernaPitagorica = esTerna;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificador de Terna Pitagórica' ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
        backgroundColor: const Color(0xFF031634),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingrese tres números para verificar si forman una terna pitagórica',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerA,
                    decoration: const InputDecoration(
                      labelText: 'Número a',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controllerB,
                    decoration: const InputDecoration(
                      labelText: 'Número b',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controllerC,
                    decoration: const InputDecoration(
                      labelText: 'Número c',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verificarTerna,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Verificar',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            if (_resultado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _esTernaPitagorica == null
                      ? Colors.grey[200]
                      : _esTernaPitagorica!
                      ? Colors.green[100]
                      : Colors.red[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _esTernaPitagorica == null
                        ? Colors.grey
                        : _esTernaPitagorica!
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                child: Text(
                  _resultado,
                  style: TextStyle(
                    fontSize: 18,
                    color: _esTernaPitagorica == null
                        ? Colors.grey[800]
                        : _esTernaPitagorica!
                        ? Colors.green[900]
                        : Colors.red[900],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    _controllerC.dispose();
    super.dispose();
  }
}