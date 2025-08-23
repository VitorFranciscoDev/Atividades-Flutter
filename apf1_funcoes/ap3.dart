import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

//Enum para as situações de jogo
enum Situacoes {
  jogando,
  ganhou,
  perdeu,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: TelaJogo(),
        ),
      ),
    );
  }
}

class TelaJogo extends StatefulWidget {
  
  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final random = Random();

  var botaoCorreto = 0;
  var clicks = 0;
  int vitorias = 0;
  int derrotas = 0;
  Situacoes situacao = Situacoes.jogando; //Situação atual do jogo

  // Esse método e chamado somente uma vez, ao iniciar o state
  @override
  void initState() {
    super.initState();

    // Escolher um número de 0 a 2 para identificar escolher o botão correto e zerar as tentativas
    botaoCorreto = random.nextInt(3);
  }

  // Tratar a tentativa do usuário
  void tentativa(int opcao) {
    if(situacao != Situacoes.jogando) return;

    setState(() {
      // Verificar se a opção escolhida esta correta
      if (opcao == botaoCorreto) {
        situacao = Situacoes.ganhou;
        vitorias++; //Adiciona ao contador de vitórias
      } else {
        // Se estiver errada, incrementa o contador de clicks
        clicks++;
      }

      // Se a quantidade de clicks for maior ou igual a 2, o usuário perdeu
      if (clicks >= 2) {
        situacao = Situacoes.perdeu; //Muda a situação do jogo
        derrotas++; //Adiciona ao contador de derrotas
      }
    });
  }

  //Função para reiniciar o jogo
  void reiniciarJogo() {
    setState(() {
      //Redefine o botão, os clicks e a situação do jogo
      botaoCorreto = random.nextInt(3);
      clicks = 0; 
      situacao = Situacoes.jogando;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget situacaoWidget;

    //Switch exaustivo para as situações de jogo
    switch(situacao) {
      case Situacoes.jogando:
        situacaoWidget = JogandoWidget(onSelected: tentativa);
        break;
      case Situacoes.ganhou:
        situacaoWidget = GanhouWidget(onRestart: reiniciarJogo);
        break;
      case Situacoes.perdeu:
        situacaoWidget = PerdeuWidget(onRestart: reiniciarJogo);
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Vitórias: $vitorias / Derrotas: $derrotas"),
        Padding(padding: EdgeInsets.only(top: 50)),
        situacaoWidget,
      ],
    );
  }
}

//Widget que irá aparecer quando a situação for jogando
class JogandoWidget extends StatelessWidget {
  const JogandoWidget({super.key, required this.onSelected});
  final void Function(int) onSelected; //Função chamada quando o botão for clicado

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: const Text('A'),
          onPressed: () {
            onSelected(0); //Verifica se o botão selecionado é o certo
          },
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        ElevatedButton(
          child: const Text('B'),
          onPressed: () {
            onSelected(1); //Verifica se o botão selecionado é o certo
          },
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        ElevatedButton(
          child: const Text('C'),
          onPressed: () {
            onSelected(2); //Verifica se o botão selecionado é o certo
          },
        ),
      ],
    );
  }
}

//Widget que irá aparecer caso o usuário tenha vencido
class GanhouWidget extends StatelessWidget {
  const GanhouWidget({super.key, required this.onRestart});
  final VoidCallback onRestart; //Função chamada para reiniciar o jogo

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          const Text("Você ganhou"),
          Padding(padding: EdgeInsets.only(top: 5)),
          ElevatedButton(
            onPressed: onRestart, //Reinicia o jogo
            child: const Text("Jogar novamente")
          ),
        ],
      ),
    );
  }
}

//Widget que irá aparecer caso o usuário tenha perdido
class PerdeuWidget extends StatelessWidget {
  const PerdeuWidget({super.key, required this.onRestart});
  final VoidCallback onRestart; //Função chamada para reiniciar o jogo

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          const Text("Você perdeu"),
          Padding(padding: EdgeInsets.only(top: 5)),
          ElevatedButton(
            onPressed: onRestart, //Reinicia o jogo
            child: const Text("Jogar novamente")
          ),
        ],
      ),
    );
  }
}