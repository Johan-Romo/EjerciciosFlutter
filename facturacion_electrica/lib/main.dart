import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facturación Eléctrica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BillingScreen(),
    );
  }
}

class BillingScreen extends StatefulWidget {
  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final TextEditingController _consumoController = TextEditingController();
  String _resultado = '';

  void _calcularValorAPagar() {
    // Obtener el consumo ingresado
    String consumoStr = _consumoController.text;

    // Validar si el campo está vacío
    if (consumoStr.isEmpty) {
      _mostrarMensaje("Por favor ingrese el consumo de KWH");
      return;
    }

    // Convertir el consumo a entero
    int consumo = int.tryParse(consumoStr) ?? -1;

    // Validar si el consumo es un número positivo
    if (consumo <= 0) {
      _mostrarMensaje("El consumo debe ser un número positivo");
      return;
    }

    double costo = 0.0;

    // Calcular el costo según el consumo
    if (consumo <= 50) {
      costo = consumo * 30.0;
    } else if (consumo <= 100) {
      costo = (50 * 30.0) + ((consumo - 50) * 35.0);
    } else {
      costo = (50 * 30.0) + (50 * 35.0) + ((consumo - 100) * 42.0);
    }

    // Calcular el IVA (13%)
    double iva = costo * 0.13;
    double total = costo + iva;

    // Mostrar el resultado
    setState(() {
      _resultado = "El total a pagar es: \$${total.toStringAsFixed(2)}";
    });
  }

  void _mostrarMensaje(String mensaje) {
    // Mostrar un mensaje de alerta (snackbar)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facturación Eléctrica"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ingrese el consumo de KWH del cliente:',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _consumoController,
              decoration: InputDecoration(
                hintText: "Consumo en KWH",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularValorAPagar,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              _resultado,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
