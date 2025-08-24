import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum Indicador { ativo, inativo }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormularioBasico(),
    );
  }
}

class FormularioBasico extends StatefulWidget {
  const FormularioBasico({super.key});

  @override
  State<FormularioBasico> createState() => _FormularioBasicoState();
}

class _FormularioBasicoState extends State<FormularioBasico> {
  //Controllers dos Text Fields
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();

  bool nomeValido = false;
  bool idadeValida = false;

  String nome = '';
  int idade = 0;

  //Variáveis que aparecem caso os dados não sejam válidos
  String? erroNome;
  String? erroIdade;

  Indicador indicador = Indicador.inativo;
  Indicador indicadorSelecionado = Indicador.inativo;

  //Função para verificar as informações e salvar os dados
  void verificarInformacoes() {
    setState(() {

      if (nomeController.text.isEmpty) { //Verifica se o nome é vazio
        nomeValido = false;
        erroNome = "O nome não pode estar vazio";
      } else if (nomeController.text.length < 3) { //Verifica se o nome tem menos de 3 letras
        nomeValido = false;
        erroNome = "O nome precisa ter, pelo menos, 3 letras";
      } else if (nomeController.text[0] !=
          nomeController.text[0].toUpperCase()) { //Verifica se a primeira letra do nome é maiúscula
        nomeValido = false;
        erroNome = "A primeira letra do nome deve ser maiúscula";
      } else { //Se tudo der falso, o nome é válido
        nomeValido = true;
        erroNome = null;
        nome = nomeController.text;
      }

      int? id = int.tryParse(idadeController.text);
      if (id == null) { //Verifica se a idade é nula
        idadeValida = false;
        erroIdade = "Digite um número válido";
      } else if (id < 18) { //Verifica se a idade é menor que 18
        idadeValida = false;
        erroIdade = "A idade mínima é 18";
      } else { //Se tudo der falso, a idade é válida
        idadeValida = true;
        erroIdade = null;
        idade = id;
      }

      //Se nome e idade forem válidos, o indicador é salvo
      if(nomeValido && idadeValida) {
        indicador = indicadorSelecionado;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  hintText: "Nome",
                  errorText: erroNome, //Mensagem de erro
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 50)),

              TextField(
                controller: idadeController,
                decoration: InputDecoration(
                  hintText: "Idade",
                  errorText: erroIdade, //Mensagem de erro
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 50)),

              Row(
                children: [
                  Radio<Indicador>(
                    value: Indicador.ativo,
                    groupValue: indicadorSelecionado,
                    onChanged: (Indicador? i) {
                      setState(() {
                        indicadorSelecionado = i ?? Indicador.ativo;
                      });
                    },
                  ),

                  const Text("Ativo"),

                  Padding(padding: EdgeInsets.only(right: 30)),

                  Radio<Indicador>(
                    value: Indicador.inativo,
                    groupValue: indicadorSelecionado,
                    onChanged: (Indicador? i) {
                      setState(() {
                        indicadorSelecionado = i ?? Indicador.inativo;
                      });
                    },
                  ),

                  const Text("Inativo"),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 50)),

              OutlinedButton(
                onPressed: verificarInformacoes, //Chama a função para verificar as informações e salvar os dados
                child: const Text("Salvar"),
              ),

              Padding(padding: EdgeInsets.only(top: 50)),

              Container(
                width: 180,
                color: indicador == Indicador.ativo //Se for true, o Container fica verde, se for falso, fica cinza
                    ? Colors.green
                    : Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nome: $nome", style: TextStyle(fontSize: 16)),
                    Text("Idade: $idade", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
