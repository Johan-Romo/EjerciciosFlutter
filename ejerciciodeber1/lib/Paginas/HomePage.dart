import 'package:ejerciciodeber1/Paginas/ClasificadorEdad.dart';
import 'package:ejerciciodeber1/Paginas/FacturaElectrica.dart';
import 'package:ejerciciodeber1/Paginas/TernaPitagorica.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ejerciciodeber1/Paginas/TreeCalculatorPage.dart';
import 'Randomicos.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(

        child: Container(

          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Color(0xFFe8ddcb),

                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Image.network("https://upload.wikimedia.org/wikipedia/commons/3/3a/Logo_ESPEOk.png"),
              ),
              const Text(
                "Menu de ejercicios",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 1:"),
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
                      title: const Text("Ejercicio 2:"),
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
                      title: const Text("Ejercicio 3:"),
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
                      title: const Text("Ejercicio 4:"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FacturaElectrica(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 5:"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TernaPitagorica(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.calculate),
                      title: const Text("Ejercicio 6:"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TreeCalculatorPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Ejercicios Desarrollados'),
        backgroundColor: Color(0xFF031634),
        foregroundColor: Colors.white,
      ),
      body: Center(

          child: Padding(
          padding: const EdgeInsets.all(35.0),
            child: Text("Seleccione un ejercicio en el menú"),

          )

      ),
    );
  }
}