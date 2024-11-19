import 'package:flutter/material.dart';

class CalculadoraSueldo {
  static const int limiteSinComision = 4000000;
  static const int limiteComisionBaja = 10000000;

  static Map<String, dynamic> calcularSueldoMensual({
    required double sueldoBase,
    required double ventasMensuales,
  }) {
    double comision = 0;
    String tipoComision = "Sin comisión";

    if (ventasMensuales >= limiteComisionBaja) {
      comision = ventasMensuales * 0.07;
      tipoComision = "Comisión del 7%";
    } else if (ventasMensuales >= limiteSinComision) {
      comision = ventasMensuales * 0.03;
      tipoComision = "Comisión del 3%";
    }

    return {
      'sueldoTotal': sueldoBase + comision,
      'tipoComision': tipoComision,
    };
  }
}

class PaginaCalculadoraSueldo extends StatefulWidget {
  @override
  _PaginaCalculadoraSueldoState createState() => _PaginaCalculadoraSueldoState();
}

class _PaginaCalculadoraSueldoState extends State<PaginaCalculadoraSueldo> {
  final TextEditingController _controladorSueldoBase = TextEditingController();
  final TextEditingController _controladorVentas = TextEditingController();

  String? _resultado;
  String? _tipoComision;

  void _calcularSueldo() {
    setState(() {
      _resultado = null;
      _tipoComision = null;
    });

    final double? sueldoBase = double.tryParse(_controladorSueldoBase.text);
    final double? ventas = double.tryParse(_controladorVentas.text);

    if (sueldoBase == null || ventas == null || sueldoBase < 0 || ventas < 0) {
      setState(() {
        _resultado = 'Por favor ingrese valores válidos.';
      });
      return;
    }

    final resultado = CalculadoraSueldo.calcularSueldoMensual(
      sueldoBase: sueldoBase,
      ventasMensuales: ventas,
    );

    setState(() {
      _resultado = 'El sueldo mensual es: \$${resultado['sueldoTotal'].toStringAsFixed(2)}';
      _tipoComision = resultado['tipoComision'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Calculadora de Sueldo' ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
        backgroundColor: const Color(0xFF031634),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese sus datos para calcular el sueldo mensual correspondiente:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFcdb380),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingrese los datos:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  _crearCampoTexto(
                    controlador: _controladorSueldoBase,
                    etiqueta: 'Sueldo Base',
                  ),
                  SizedBox(height: 16),
                  _crearCampoTexto(
                    controlador: _controladorVentas,
                    etiqueta: 'Ventas del Mes',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularSueldo,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF033649),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Calcular Sueldo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_resultado != null || _tipoComision != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFB0802E),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_resultado != null)
                      Text(
                        _resultado!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    if (_tipoComision != null) ...[
                      SizedBox(height: 10),
                      Text(
                        _tipoComision!,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _crearCampoTexto({
    required TextEditingController controlador,
    required String etiqueta,
  }) {
    return TextField(
      controller: controlador,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: etiqueta,
        labelStyle: TextStyle(color: Colors.black26),
        filled: true,
        fillColor: const Color(0xFFFEF9E0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0xFF5D5FEF)),
        ),
      ),
    );
  }
}
