import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'Paginas/Randomicos.dart';
import 'Paginas/HomePage.dart';
// Clase principal del ejercicio
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Añade el key constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Generador de Numero Randomico",
      home: HomePage(), // Movemos el Scaffold a una nueva página
    );
  }
}