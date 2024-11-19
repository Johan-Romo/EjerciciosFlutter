import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PantallaFacturaElectrica extends StatefulWidget {
    const PantallaFacturaElectrica({super.key});


@override
State<PantallaFacturaElectrica> createState() => _PantallaFacturaElectricaState();
}



class _PantallaFacturaElectricaState extends State<PantallaFacturaElectrica> {
  final TextEditingController _controladorConsumo = TextEditingController();
  double _costoTotal = 0.0;
  final double _iva = 0.12; // IVA del 12%

  void _calcularFactura() {
    setState(() {
      final String entrada = _controladorConsumo.text.trim();

      // Validación: Campo vacío
      if (entrada.isEmpty) {
        _mostrarError("El campo de consumo no puede estar vacío.");
        return;
      }

      // Validación: Formato numérico
      final double? consumo = double.tryParse(entrada);
      if (consumo == null) {
        _mostrarError("Por favor, ingrese un número válido.");
        return;
      }

      // Validación: Número negativo
      if (consumo < 0) {
        _mostrarError("El consumo no puede ser negativo.");
        return;
      }

      // Validación: Valor irreal o extremadamente alto
      if (consumo > 1000000) {
        _mostrarError(
            "El consumo ingresado es demasiado alto. Por favor, revise el valor.");
        return;
      }

      // Cálculo del costo base
      double costoBase = 0.0;
      if (consumo <= 50) {
        costoBase = consumo * 30;
      } else if (consumo <= 100) {
        costoBase = (50 * 30) + ((consumo - 50) * 35);
      } else {
        costoBase = (50 * 30) + (50 * 35) + ((consumo - 100) * 42);
      }

      // Cálculo del IVA y costo total
      final double totalConIva = costoBase + (costoBase * _iva);
      _costoTotal = totalConIva;
    });
  }

  void _mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Costo Facturación Electrónica' ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
        backgroundColor: const Color(0xFF031634),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calcule el valor de la factura a pagar::',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _controladorConsumo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Consumo en KWH",
                border: OutlineInputBorder(),
                hintText: "Ingrese el consumo en KWH",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calcularFactura,
              child: Text("Calcular"),
            ),
            SizedBox(height: 16.0),
            Text(
              "Costo total: \$${_costoTotal.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controladorConsumo.dispose();
    super.dispose();
  }
}
