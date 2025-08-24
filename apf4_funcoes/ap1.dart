import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ListaDeCores());
  }
}

class ListaDeCores extends StatelessWidget {
  ListaDeCores({super.key});

  //Map com todas as cores
  final Map<String, Color> coresMap = {
    "Vermelho": Colors.red,
    "Azul": Colors.blue,
    "Amarelo": Colors.yellow,
    "Preto": Colors.black,
    "Roxo": Colors.purple,
    "Rosa": Colors.pink,
    "Laranja": Colors.orange,
    "Verde": Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: coresMap.entries
              .map(
                (entry) => //Itera sobre os pares do Map
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //Quando o texto for clicado, vai para TelaCor
                        builder: (context) => TelaCor(
                          nome: entry.key,
                          cor: entry.value,
                        ), //Passa o nome e a cor como parâmetros para a tela com a cor
                      ),
                    );
                  },
                  child: Text(
                    entry.key, //Texto que aparece na tela
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              )
              .toList(), //Converte para List
        ),
      ),
    );
  }
}

class TelaCor extends StatelessWidget {
  //Variáveis que TelaCor irá receber da ListaDeCores
  final String nome;
  final Color cor;

  const TelaCor({super.key, required this.nome, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cor, //Cor de fundo
      body: Center(
        child: Text(
          nome,
          style: const TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); //Quando clicado, volta pra tela ListaDeCores
        },
        child: const Icon(Icons.arrow_back), //Ícone de flecha
      ),
    );
  }
}
