import 'package:ejerciciodeber1/Paginas/CalculadoraSueldo.dart';
import 'package:ejerciciodeber1/Paginas/ClasificadorEdad.dart';
import 'package:ejerciciodeber1/Paginas/PantallaFacturaElectrica.dart';
import 'package:ejerciciodeber1/Paginas/TernaPitagorica.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ejerciciodeber1/Paginas/TreeCalculatorPage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe8ddcb),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF033649),
          child: Column(
            children: [
              Container(

                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/3/3a/Logo_ESPEOk.png"),
              ),
              const Text(
                "Menu de ejercicios",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 1:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white), ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClasificadorEdad(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 2:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TernaPitagorica(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 3:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PantallaFacturaElectrica(),
                          ),
                        );
                      },
                    ),

                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 4:",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaginaCalculadoraSueldo(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 5:",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TreeCalculatorPage(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Tarea 1 - Primera Parcial'),
        backgroundColor: const Color(0xFF031634),
        foregroundColor: Colors.white,
      ),

      body: Column(

        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Tarea 1.1: Creación y ejecución de una Activity",
              style: GoogleFonts.robotoCondensed(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF37474F),

              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: const Color(0xFFcdb380), // Color de fondo para los nombres
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10),
            child: Text(
              "Nombres:",
              style: GoogleFonts.robotoCondensed(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Container(

            child: Text(
              "Nahir Carrera\nJohan Romo\nSebastián Arias\nChristopher Bazurto",
              style: GoogleFonts.robotoCondensed(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Container(
            color: const Color(0xFFcdb380), // Color de fondo para el NRC
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10),
            child: Text(
              "NRC: 2512",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),

          // Espacio vacío entre la información y la selección de ejercicios
          const SizedBox(height: 40),

          // Bloque 4: Mensaje de selección
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Seleccione un ejercicio en el menú",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
