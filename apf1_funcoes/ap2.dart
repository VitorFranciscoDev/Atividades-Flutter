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
      home: OpcaoAleatoria(),
    );
  }
}

class OpcaoAleatoria extends StatefulWidget {
  const OpcaoAleatoria({super.key});

  @override
  State<OpcaoAleatoria> createState() => _OpcaoAleatoriaState();
}

class _OpcaoAleatoriaState extends State<OpcaoAleatoria> {
  int botaoAleatorio = Random().nextInt(3); //Escolhe o botão aleatório
  bool botaoCerto = false;
  bool perdeu = false;
  int tentativas = 0;

  //Função para checar se o botão certo é o selecionado
  void checarBotao(int opcao) {
    if(opcao == botaoAleatorio) {
      setState(() {
        botaoCerto = true;
      });
    } else {
      tentativas++; //Aumenta o número de tentativas
    }

    //Se o usuário fizer 2 tentativas e não ter acertado o botão, ele perde o jogo
    if(tentativas==2 && botaoCerto!=true) {
      setState(() {
        perdeu = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(perdeu) {
      return Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Você perdeu!"),
            ],
          ),
        ),
      );
    }

    if(botaoCerto) {
      return Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Você ganhou!"),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Clique em um botão"),
            Padding(padding: EdgeInsets.only(top: 50)),
            TextButton(
              onPressed: () => checarBotao(0), //Chama a função para verificar se esse é o botão correto
              child: const Text("Botão A"),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextButton(
              onPressed: () => checarBotao(1), //Chama a função para verificar se esse é o botão correto
              child: const Text("Botão B"),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            TextButton(
              onPressed: () => checarBotao(2), //Chama a função para verificar se esse é o botão correto
              child: const Text("Botão C"),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
          ],
        ),
      ),
    );
  }
}