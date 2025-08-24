import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormatosDinamicos(),
    );
  }
}

class FormatosDinamicos extends StatefulWidget {
  const FormatosDinamicos({super.key});

  @override
  State<FormatosDinamicos> createState() => _FormatosDinamicosState();
}

class _FormatosDinamicosState extends State<FormatosDinamicos> {
  String forma = "quadrado"; //Forma inicial
  Color cor = Colors.yellow; //Cor da forma
  String get proximaForma => forma == "quadrado" ? "círculo" : "quadrado"; //getter para pegar a próxima forma

  //Função para mudar a forma
  void mudarForma() {
    setState(() {
      forma = proximaForma;
    });
  }

  //Função para mudar a cor
  void mudarCor() {
    setState(() {
      cor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: mudarForma, //Muda a forma quando clicado
                  child: Text("Mudar para $proximaForma"),
                ),

                Padding(padding: EdgeInsets.only(right: 10)),

                TextButton(
                  onPressed: mudarCor, //Muda a cor quando clicado
                  child: const Text("Cor aleatória"),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top: 30)),

            //Se a variável for igual a círculo, mostra um círculo, e se não for, mostra quadrado
            forma == "círculo" 
              ? Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cor,
                ),
              )
              : Container(width: 100, height: 100, color: cor),
          ],
        ),
      ),
    );
  }
}
