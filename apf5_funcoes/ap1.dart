import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EstadoListaDePessoas(), //Provider
      child: MyApp(),
    ),
  );
}

//Enum com todos os tipos sanguíneos
enum TipoSanguineo {
  aPositivo,
  aNegativo,
  bPositivo,
  bNegativo,
  oPositivo,
  oNegativo,
  abPositivo,
  abNegativo,
}

//Classe com os atributos de pessoa
class Pessoa extends ChangeNotifier {
  Pessoa({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.github,
    required this.tipoSanguineo,
  });

  String nome;
  String email;
  String telefone;
  String github;
  TipoSanguineo tipoSanguineo;

  //Sobrescrita do == e do hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pessoa &&
          runtimeType == other.runtimeType &&
          nome == other.nome &&
          email == other.email &&
          telefone == other.telefone &&
          github == other.github &&
          tipoSanguineo == other.tipoSanguineo;

  @override
  int get hashCode =>
      nome.hashCode ^
      email.hashCode ^
      telefone.hashCode ^
      github.hashCode ^
      tipoSanguineo.hashCode;
}

class EstadoListaDePessoas with ChangeNotifier {
  final _listaDePessoas = <Pessoa>[]; //Lista de pessoas

  List<Pessoa> get pessoas =>
      List.unmodifiable(_listaDePessoas); //getter para pessoas

  //Função para incluir pessoas
  void incluir(Pessoa pessoa) {
    _listaDePessoas.add(pessoa);
    notifyListeners();
  }

  //Função para excluir pessoas
  void excluir(Pessoa pessoa) {
    _listaDePessoas.remove(pessoa);
    notifyListeners();
  }

  //Função para editar pessoa
  void editar(Pessoa pessoaAntiga, Pessoa pessoaNova) {
    final index = _listaDePessoas.indexOf(pessoaAntiga);
    if (index != -1) {
      _listaDePessoas[index] = pessoaNova;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Tela Inicial", style: TextStyle(fontSize: 14)),

            Padding(padding: EdgeInsets.only(top: 30)),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaLista(),
                  ), //Vai para a tela da lista de pessoas
                );
              },
              child: Text("Lista de Pessoas"),
            ),

            Padding(padding: EdgeInsets.only(top: 30)),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaIncluirPessoas(),
                  ), //Vai para a tela de incluir pessoas na lista
                );
              },
              child: Text("Incluir pessoas"),
            ),

            Padding(padding: EdgeInsets.only(top: 30)),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaExcluirPessoas(),
                  ), //Vai para a tela de excluir pessoas da lista
                );
              },
              child: Text("Excluir pessoas"),
            ),

            Padding(padding: EdgeInsets.only(top: 30)),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaEditarPessoas(),
                  ), //Vai para a tela de edição de pessoas
                );
              },
              child: Text("Editar pessoas"),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  TipoSanguineo? filtro; //filtro por tipo sanguíneo

  //getter para pegar o texto de tipo sanguíneo
  String tipoSanguineoTexto(TipoSanguineo tipo) {
    switch (tipo) {
      case TipoSanguineo.aPositivo:
        return "A+";
      case TipoSanguineo.aNegativo:
        return "A-";
      case TipoSanguineo.bPositivo:
        return "B+";
      case TipoSanguineo.bNegativo:
        return "B-";
      case TipoSanguineo.oPositivo:
        return "O+";
      case TipoSanguineo.oNegativo:
        return "O-";
      case TipoSanguineo.abPositivo:
        return "AB+";
      case TipoSanguineo.abNegativo:
        return "AB-";
    }
  }

  //Map das cores com base no tipo sanguíneo
  Map<TipoSanguineo, Color> cores = {
    TipoSanguineo.aPositivo: Colors.blue,
    TipoSanguineo.aNegativo: Colors.red,
    TipoSanguineo.bPositivo: Colors.purple,
    TipoSanguineo.bNegativo: Colors.orange,
    TipoSanguineo.oPositivo: Colors.green,
    TipoSanguineo.oNegativo: Colors.yellow,
    TipoSanguineo.abPositivo: Colors.cyan,
    TipoSanguineo.abNegativo: Colors.white,
  };

  @override
  Widget build(BuildContext context) {
    final pessoas = context.watch<EstadoListaDePessoas>().pessoas;
    final pessoasFiltradas =
        filtro ==
            null //Se filtro for null, retorna pessoas, se não for, retorna o filtro do tipo selecionado
        ? pessoas
        : pessoas.where((p) => p.tipoSanguineo == filtro).toList();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: DropdownButton<TipoSanguineo?>(
                //Dropdown que mostra as opções de filtro
                value: filtro,
                hint: const Text("Filtrar dados"),
                isExpanded: true,
                items: [
                  //Itens do Dropdown
                  const DropdownMenuItem(value: null, child: Text("Todos")),
                  ...TipoSanguineo.values.map(
                    (tipo) => DropdownMenuItem(
                      value: tipo,
                      child: Text(tipoSanguineoTexto(tipo)),
                    ),
                  ),
                ],
                onChanged: (novoFiltro) {
                  setState(() {
                    filtro = novoFiltro; //Seleciona o novo filtro
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                //Mostra a lista de pessoas
                itemCount: pessoasFiltradas.length,
                itemBuilder: (context, index) {
                  final pessoa = pessoasFiltradas[index];
                  return ListTile(
                    title: Text(pessoa.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${pessoa.email}"),
                        Text("Telefone: ${pessoa.telefone}"),
                        Text("GitHub: ${pessoa.github}"),
                        Text(
                          "Tipo sanguíneo: ${tipoSanguineoTexto(pessoa.tipoSanguineo)}",
                          style: TextStyle(color: cores[pessoa.tipoSanguineo]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); //Volta para a tela inicial
                },
                child: const Text("Voltar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaIncluirPessoas extends StatefulWidget {
  const TelaIncluirPessoas({super.key});

  @override
  State<TelaIncluirPessoas> createState() => _TelaIncluirPessoasState();
}

class _TelaIncluirPessoasState extends State<TelaIncluirPessoas> {
  //Controllers dos campos de texto
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _githubController = TextEditingController();

  //Variáveis de erro
  String? erroNome;
  String? erroEmail;
  String? erroTelefone;
  String? erroGitHub;

  bool nomeValido = false;
  bool emailValido = false;
  bool telefoneValido = false;
  bool gitHubValido = false;

  List<String> alfabeto = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];

  TipoSanguineo _tipo = TipoSanguineo.aPositivo;

  //Função que retorna true ou false caso a palavra tenha letras ou não
  bool letras(String texto) {
    for (var char in texto.split('')) {
      if (!alfabeto.contains(char)) {
        return false;
      }
    }
    return true;
  }

  //Função que retorna true ou false caso a palavra tenha números ou não
  bool numeros(String texto) {
    return RegExp(r'^[0-9]+$').hasMatch(texto);
  }

  void validarPessoa() {
    setState(() {
      if (_nomeController.text.isEmpty) { //Se nome for vazio, atualiza mensagem de erro
        erroNome = "Nome não pode ser vazio";
        nomeValido = false;
      } else if (!letras(_nomeController.text)) { //Se nome não tiver apenas letras, atualiza mensagem de erro
        erroNome = "Nome só pode conter letras";
        nomeValido = false;
      } else { //Se não tiver nada errado, não há mensagem de erro
        erroNome = null;
        nomeValido = true;
      }

      if (_emailController.text.isEmpty) { //Se email for vazio, atualiza mensagem de erro
        erroEmail = "Email não pode ser vazio";
        emailValido = false;
      } else if (!_emailController.text.contains("@")) { //Se email não tiver @, atualiza mensagem de erro
        erroEmail = "Email precisa ter @";
        emailValido = false;
      } else { //Se não houver erros, não há mensagem de erro
        erroEmail = null;
        emailValido = true;
      }

      if (_telefoneController.text.isEmpty) { //Se telefone for vazio, atualiza mensagem de erro
        erroTelefone = "Telefone não pode ser vazio";
        telefoneValido = false;
      } else if (!numeros(_telefoneController.text)) { //Se telefone não tiver apenas números, atualiza mensagem de erro
        erroTelefone = "Telefone só pode contar números";
        telefoneValido = false;
      } else { //Se não houver erros, não há mensagem de erro
        erroTelefone = null;
        telefoneValido = true;
      }

      if (_githubController.text.isEmpty) { //Se link do GitHub for vazio, atualiza mensagem de erro
        erroGitHub = "Link do GitHub não pode ser vazio";
        gitHubValido = false;
      } else if (!_githubController.text.contains(".com")) { //Se link do GitHub não ter .com, atualiza mensagem de erro
        erroGitHub = "Link precisa ter .com";
        gitHubValido = false;
      } else { //Se não houver erros, não há mensagem de erro
        erroGitHub = null;
        gitHubValido = true;
      }

      if (nomeValido && emailValido && telefoneValido && gitHubValido) {
        //Parâmetros
        final pessoa = Pessoa(
          nome: _nomeController.text,
          email: _emailController.text,
          telefone: _telefoneController.text,
          github: _githubController.text,
          tipoSanguineo: _tipo,
        );
        context.read<EstadoListaDePessoas>().incluir(pessoa); //Coloca a pessoa na lista
      }
    });
  }

  //Widget para radio button
  Widget _radio(TipoSanguineo tipo, String tipoTexto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<TipoSanguineo>(
          visualDensity: VisualDensity.compact,
          value: tipo,
          groupValue: _tipo,
          onChanged: (selecionado) {
            setState(() {
              _tipo = selecionado!; //Alterna para o selecionado
            });
          },
        ),
        Text(tipoTexto, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                //TextField de nome
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  errorText: erroNome,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),

              TextField(
                //TextField de email
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: erroEmail,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),

              TextField(
                //TextField de telefone
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  errorText: erroTelefone,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),

              TextField(
                //TextField de link do github
                controller: _githubController,
                decoration: InputDecoration(
                  labelText: "Link do GitHub",
                  errorText: erroGitHub,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),

              Row(
                //Row com os radioButtons
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _radio(TipoSanguineo.aPositivo, "A+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.aNegativo, "A-"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.bPositivo, "B+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.bNegativo, "B-"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _radio(TipoSanguineo.oPositivo, "O+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.oNegativo, "O-"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.abPositivo, "AB+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.abNegativo, "AB-"),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 40)),

              ElevatedButton(
                onPressed: () =>
                    validarPessoa(), //Valida as informações e adiciona a pessoa na lista
                child: const Text("Adicionar Pessoa"),
              ),

              Padding(padding: EdgeInsets.only(top: 20)),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); //Volta para a tela inicial
                },
                child: const Text("Voltar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaExcluirPessoas extends StatefulWidget {
  const TelaExcluirPessoas({super.key});

  @override
  State<TelaExcluirPessoas> createState() => _TelaExcluirPessoasState();
}

class _TelaExcluirPessoasState extends State<TelaExcluirPessoas> {
  int? pessoaSelecionadaIndex; //Índice da pessoa selecionada

  @override
  Widget build(BuildContext context) {
    final pessoas = context.watch<EstadoListaDePessoas>().pessoas; //Puxa a lista pessoas do provider
    final pessoaSelecionada = pessoaSelecionadaIndex != null
        ? pessoas[pessoaSelecionadaIndex!]
        : null;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: const Text("Clique na pessoa para remove-la."),
            ),
            Expanded(
              child: ListView.builder(
                //Mostra a lista de pessoas
                itemCount: pessoas.length,
                itemBuilder: (context, index) {
                  final pessoa = pessoas[index];
                  return ListTile(
                    title: Text("Nome: ${pessoa.nome}"),
                    subtitle: Text("Telefone: ${pessoa.telefone}"),
                    tileColor: pessoaSelecionadaIndex == index ? Colors.red : null,
                    onTap: () {
                      setState(() {
                        //Se clicar na mesma pessoa, a pessoa selecionada é desmarcada
                        if (pessoaSelecionadaIndex == index) {
                          pessoaSelecionadaIndex = null;
                        } else { //Senão uma nova pessoa é selecionada
                          pessoaSelecionadaIndex = index;
                        }
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed:
                  pessoaSelecionada ==
                      null //Se for null, não acontece nada, caso contrário, mostra um AlertDialog pedindo para confirmar a exclusão
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Confirmar exclusão"),
                          content: Text(
                            "Deseja excluir ${pessoaSelecionada.nome}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(ctx), //Sai do AlertDialog
                              child: const Text("Cancelar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //Remove a pessoa selecionada
                                context.read<EstadoListaDePessoas>().excluir(
                                  pessoaSelecionada,
                                );
                                setState(() {
                                  pessoaSelecionadaIndex = null;
                                });
                                Navigator.pop(ctx); //Sai do AlertDialog
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text("Excluir"),
                            ),
                          ],
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Excluir Selecionado"),
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context), //Volta para tela inicial
                child: const Text("Voltar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaEditarPessoas extends StatefulWidget {
  const TelaEditarPessoas({super.key});

  @override
  State<TelaEditarPessoas> createState() => _TelaEditarPessoasState();
}

class _TelaEditarPessoasState extends State<TelaEditarPessoas> {
  @override
  Widget build(BuildContext context) {
    final pessoas = context.watch<EstadoListaDePessoas>().pessoas; //Pega a lista de pessoas do provider
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: const Text("Clique na pessoa para editá-la."),
          ),
          Expanded(
            child: ListView.builder(
              //Mostra a lista de pessoas
              itemCount: pessoas.length,
              itemBuilder: (context, index) {
                final pessoa = pessoas[index];
                return ListTile(
                  title: Text(pessoa.nome),
                  subtitle: Text(pessoa.telefone),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditarPessoa(
                          pessoa: pessoa,
                        ), //Vai para a tela de editar a pessoa
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context), //Volta para a tela inicial
              child: const Text("Voltar"),
            ),
          ),
        ],
      ),
    );
  }
}

class EditarPessoa extends StatefulWidget {
  final Pessoa pessoa;

  const EditarPessoa({super.key, required this.pessoa});

  @override
  State<EditarPessoa> createState() => _EditarPessoaState();
}

class _EditarPessoaState extends State<EditarPessoa> {
  //Controllers do TextFields
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _githubController;

  late TipoSanguineo _tipo;

  //Variáveis de erro
  String? erroNome;
  String? erroEmail;
  String? erroTelefone;
  String? erroGitHub;

  bool nomeValido = false;
  bool emailValido = false;
  bool telefoneValido = false;
  bool gitHubValido = false;

  List<String> alfabeto = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];

  //Função booleana que retorna true caso haja apenas letras no texto
  bool letras(String texto) {
    for (var char in texto.split('')) {
      if (!alfabeto.contains(char)) {
        return false;
      }
    }
    return true;
  }

  //Função booleana que retorna true caso haja apenas números no texto
  bool numeros(String texto) {
    return RegExp(r'^[0-9]+$').hasMatch(texto);
  }

  void validarPessoa() {
    setState(() {
      if (_nomeController.text.isEmpty) { //Se o nome for vazio, atualiza a mensagem de erro
        erroNome = "Nome não pode ser vazio";
        nomeValido = false;
      } else if (!letras(_nomeController.text)) { //Se o nome não ter apenas letras, atualiza a mensagem de erro
        erroNome = "Nome só pode conter letras";
        nomeValido = false;
      } else { //Se tudo estiver certo, não há mensagem de erro
        erroNome = null;
        nomeValido = true;
      }

      if (_emailController.text.isEmpty) { //Se o email for vazio, atualiza a mensagem de erro
        erroEmail = "Email não pode ser vazio";
        emailValido = false;
      } else if (!_emailController.text.contains("@")) { //Se o email não ter @, atualiza a mensagem de erro
        erroEmail = "Email precisa ter @";
        emailValido = false;
      } else { //Se tudo estiver certo, não há mensagem de erro
        erroEmail = null;
        emailValido = true;
      }

      if (_telefoneController.text.isEmpty) { //Se o telefone for vazio, atualiza a mensagem de erro
        erroTelefone = "Telefone não pode ser vazio";
        telefoneValido = false;
      } else if (!numeros(_telefoneController.text)) { //Se o telefone não ter apenas números, atualiza a mensagem de erro
        erroTelefone = "Telefone só pode contar números";
        telefoneValido = false;
      } else { //Se tudo estiver certo, não há mensagem de erro
        erroTelefone = null;
        telefoneValido = true;
      }

      if (_githubController.text.isEmpty) { //Se o link do GitHub for vazio, atualiza a mensagem de erro
        erroGitHub = "Link do GitHub não pode ser vazio";
        gitHubValido = false;
      } else if (!_githubController.text.contains(".com")) { //Se o link do GitHub não ter .com, atualiza a mensagem de erro
        erroGitHub = "Link precisa ter .com";
        gitHubValido = false;
      } else { //Se tudo estiver certo, não há mensagem de erro
        erroGitHub = null;
        gitHubValido = true;
      }

      if (nomeValido && emailValido && telefoneValido && gitHubValido) {
        //Edita a pessoa
        final pessoaEditada = Pessoa(
          nome: _nomeController.text,
          email: _emailController.text,
          telefone: _telefoneController.text,
          github: _githubController.text,
          tipoSanguineo: _tipo,
        );
        context.read<EstadoListaDePessoas>().editar(
          widget.pessoa,
          pessoaEditada,
        );
        Navigator.pop(context); //Sai da tela
      }
    });
  }

  @override
  void initState() { //Inicializa o estado
    super.initState();
    _nomeController = TextEditingController(text: widget.pessoa.nome);
    _emailController = TextEditingController(text: widget.pessoa.email);
    _telefoneController = TextEditingController(text: widget.pessoa.telefone);
    _githubController = TextEditingController(text: widget.pessoa.github);
    _tipo = widget.pessoa.tipoSanguineo;
  }

  //Widget de RadioButton
  Widget _radio(TipoSanguineo tipo, String tipoTexto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<TipoSanguineo>(
          visualDensity: VisualDensity.compact,
          value: tipo,
          groupValue: _tipo,
          onChanged: (selecionado) {
            setState(() {
              _tipo = selecionado!; //Alterna para o selecionado
            });
          },
        ),
        Text(tipoTexto),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                //TextField do Nome
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  errorText: erroNome,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 30)),

              TextField(
                //TextField do Email
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: erroEmail,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 30)),

              TextField(
                //TextField do Telefone
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  errorText: erroTelefone,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 30)),

              TextField(
                //TextField do Link do GitHub
                controller: _githubController,
                decoration: InputDecoration(
                  labelText: "GitHub",
                  errorText: erroGitHub,
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 30)),

              Row(
                //Row com radioButtons
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _radio(TipoSanguineo.aPositivo, "A+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.aNegativo, "A-"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.bPositivo, "B+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.bNegativo, "B-"),
                ],
              ),
              Row(
                //Row com radioButtons
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _radio(TipoSanguineo.oPositivo, "O+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.oNegativo, "O-"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.abPositivo, "AB+"),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  _radio(TipoSanguineo.abNegativo, "AB-"),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 30)),

              ElevatedButton(
                onPressed: () => validarPessoa(), //Valida as alterações e edita o usuário na lista
                child: const Text("Salvar Alterações"),
              ),

              Padding(padding: EdgeInsets.only(top: 30)),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context), //Volta pra tela inicial
                child: const Text("Cancelar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
