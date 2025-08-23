import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoresAleatorias(),
    );
  }
}

class CoresAleatorias extends StatefulWidget {
  const CoresAleatorias({super.key});

  @override
  State<CoresAleatorias> createState() => _CoresAleatoriasState();
}

class _CoresAleatoriasState extends State<CoresAleatorias> {
  Color cor = Colors.black; //Cor do texto
  Random random = Random();

  //Função para mudar a cor do texto
  void corAleatoria() {
    setState(() {
      cor = Color.fromARGB(255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Cores Aleatórias", style: TextStyle(color: cor)),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextButton(
              onPressed: corAleatoria, //Quando o botão for clicado, a função é chamada
              child: const Text("Mudar Cor"),
            ),
          ],
        ),
      ),
    );
  }
}