import 'package:flutter/material.dart';

class Tree {
  final String type;
  final double unitPrice;

  Tree(this.type, this.unitPrice);
}

class TreeCalculatorPage extends StatefulWidget {
  @override
  _TreeCalculatorPageState createState() => _TreeCalculatorPageState();
}

class _TreeCalculatorPageState extends State<TreeCalculatorPage> {
  final List<Tree> trees = [
    Tree('platanos', 1200),
    Tree('limones', 1000),
    Tree('chirimoyos', 980),
  ];

  Tree? selectedTree;
  final TextEditingController quantityController = TextEditingController();
  double? total;
  String calculationDetails = '';
  String? quantityError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Árboles' ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
        backgroundColor: const Color(0xFF031634),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tabla de Precios y Descuentos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(
                  children: [
                    _buildTableCell('Tipo de Árbol', bold: true),
                    _buildTableCell('Precio Unitario', bold: true),
                    _buildTableCell('Descuento (100-300)', bold: true),
                    _buildTableCell('Descuento (>300)', bold: true),
                  ],
                ),
                ...trees.map((tree) => TableRow(
                  children: [
                    _buildTableCell(tree.type),
                    _buildTableCell('\$${tree.unitPrice.toStringAsFixed(2)}'),
                    _buildTableCell(
                        tree.type == 'platanos'
                            ? '10%'
                            : tree.type == 'limones'
                            ? '12.5%'
                            : '14.5%'),
                    _buildTableCell(
                        tree.type == 'platanos'
                            ? '18%'
                            : tree.type == 'limones'
                            ? '20%'
                            : '19%'),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecciona el tipo de árbol y la cantidad',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            DropdownButton<Tree>(
              value: selectedTree,
              hint: const Text('Selecciona un árbol'),
              items: trees.map((tree) {
                return DropdownMenuItem<Tree>(
                  value: tree,
                  child: Text(tree.type),
                );
              }).toList(),
              onChanged: (Tree? value) {
                setState(() {
                  selectedTree = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Cantidad',
                errorText: quantityError,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _validateQuantity();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (quantityError != null || selectedTree == null) {
                  _showErrorDialog(context, 'Selecciona un árbol y una cantidad válida (0 a 500).');
                  return;
                }
                _calculatePrice();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF031634), // Fondo del botón
                foregroundColor: const Color(0xFF2196F3), // Color de la letra del botón
              ),
              child: const Text('Calcular Precio'),
            ),
            const SizedBox(height: 20),
            if (total != null)
              Column(
                children: [
                  Text(
                    'El total a pagar es: \$${total!.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    calculationDetails,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetCalculator,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700], // Fondo del botón
                foregroundColor: const Color(0xFF2196F3), // Color de la letra del botón
              ),
              child: const Text('Reiniciar Calculadora'),
            ),
          ],
        ),
      ),
    );
  }

  void _validateQuantity() {
    final text = quantityController.text;
    final quantity = int.tryParse(text);

    setState(() {
      if (quantity == null || quantity < 0 || quantity > 500) {
        quantityError = 'Debe ingresar un número entre 0 y 500';
      } else {
        quantityError = null;
      }
    });
  }

  void _calculatePrice() {
    final quantity = int.parse(quantityController.text);
    final unitPrice = selectedTree!.unitPrice;

    double discountRate = 0;
    if (quantity > 300) {
      discountRate = selectedTree!.type == 'platanos'
          ? 0.18
          : selectedTree!.type == 'limones'
          ? 0.20
          : 0.19;
    } else if (quantity > 100) {
      discountRate = selectedTree!.type == 'platanos'
          ? 0.10
          : selectedTree!.type == 'limones'
          ? 0.125
          : 0.145;
    }

    double basePrice = unitPrice * quantity;
    double discount = basePrice * discountRate;
    double finalPrice = basePrice - discount;

    if (quantity > 1000) {
      finalPrice -= finalPrice * 0.15;
    }

    setState(() {
      total = finalPrice * 1.12; // Incluye IVA (12%)
      calculationDetails = '''
        Paso 1: Precio sin descuento: \$${basePrice.toStringAsFixed(2)}
        Paso 2: Descuento aplicado (${(discountRate * 100).toStringAsFixed(2)}%): -\$${discount.toStringAsFixed(2)}
        Paso 3: Precio con descuento: \$${finalPrice.toStringAsFixed(2)}
        Paso 4: IVA (12%): \$${(finalPrice * 0.12).toStringAsFixed(2)}
        Total: \$${total!.toStringAsFixed(2)}
      ''';
    });
  }

  void _resetCalculator() {
    setState(() {
      selectedTree = null;
      quantityController.clear();
      total = null;
      calculationDetails = '';
      quantityError = null;
    });
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTableCell(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
