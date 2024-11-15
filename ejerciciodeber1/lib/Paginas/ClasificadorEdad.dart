import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


class ClasificadorEdad extends StatefulWidget {
  const ClasificadorEdad({super.key});

  @override
  State<ClasificadorEdad> createState() => _ClasificadorEdadState();
}

class _ClasificadorEdadState extends State<ClasificadorEdad> {
  final TextEditingController _edadController = TextEditingController();
  String _resultado = '';
  String _mensaje = '';
  Color _colorMensaje = Colors.black;
  String _imageUrl = '';

  void _clasificarEdad() {
    setState(() {
      // Validar que el campo no esté vacío
      if (_edadController.text.isEmpty) {
        _mensaje = 'Por favor, ingrese una edad';
        _colorMensaje = Colors.red;
        _resultado = '';
        _imageUrl = '';
        return;
      }

      // Convertir el texto a número
      int edad = int.tryParse(_edadController.text) ?? -1;

      // Validar que sea un número positivo
      if (edad < 0) {
        _mensaje = 'Por favor, ingrese una edad válida';
        _colorMensaje = Colors.red;
        _resultado = '';
        _imageUrl = '';
        return;
      }

      _mensaje = '';
      // Clasificar según la edad y asignar imagen correspondiente
      if (edad <= 10) {
        _resultado = 'NIÑO';
        _colorMensaje = Colors.blue;
        _imageUrl = 'https://static.vecteezy.com/system/resources/previews/016/721/629/non_2x/cartoon-kids-boy-01-free-png.png';
      } else if (edad <= 14) {
        _resultado = 'PUBER';
        _colorMensaje = Colors.green;
        _imageUrl = 'https://www.crecemos.mx/images/cambios-pubertad-433180368900486-506537.png';
      } else if (edad <= 18) {
        _resultado = 'ADOLESCENTE';
        _colorMensaje = Colors.purple;
        _imageUrl = 'https://images.vexels.com/content/204807/preview/happy-man-phone-character-2e505f.png';
      } else if (edad <= 25) {
        _resultado = 'JOVEN';
        _colorMensaje = Colors.orange;
        _imageUrl = 'https://img.freepik.com/vector-premium/estudiantes-universitarios-o-universitarios-agrupan-jovenes-felices-pie-aislados-fondo-blanco-educacion-academica-superior-diversa-reunion-multicultural_575670-1435.jpg';
      } else if (edad <= 65) {
        _resultado = 'ADULTO';
        _colorMensaje = Colors.brown;
        _imageUrl = 'https://static.vecteezy.com/system/resources/previews/024/830/925/non_2x/young-adult-male-teacher-in-glasses-explaining-with-a-pointing-gesture-educational-concepts-interactive-teaching-and-engaging-explanations-young-adult-teacher-3d-render-generative-ai-pro-png.png';
      } else {
        _resultado = 'ANCIANO';
        _colorMensaje = Colors.grey;
        _imageUrl = 'https://img.freepik.com/vector-premium/sociedad-ancianos-dibujos-animados-amantes-vejez-cuidan-mutuamente-cuando-estan-enfermos_68708-492.jpg';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clasificador de Edad'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ingrese una edad para verificar el grupo a la que pertenece',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Ingrese la edad',
                  border: OutlineInputBorder(),
                  hintText: 'Ejemplo: 25',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _clasificarEdad,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Clasificar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              if (_mensaje.isNotEmpty)
                Text(
                  _mensaje,
                  style: TextStyle(color: _colorMensaje, fontSize: 18),
                ),
              if (_resultado.isNotEmpty)
                Column(
                  children: [
                    Text(
                      _resultado,
                      style: TextStyle(
                        color: _colorMensaje,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_imageUrl.isNotEmpty)
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _colorMensaje,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: _colorMensaje,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _edadController.dispose();
    super.dispose();
  }
}