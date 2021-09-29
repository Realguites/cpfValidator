import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verifique se o CPF é verdadeiro',
      debugShowCheckedModeBanner: false,
      home: HomeCpf(),
    );
  }
}

class TodoItem {
  String nome;
  String cpf;

  bool done;

  TodoItem({required this.nome, required this.cpf, required this.done});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['nome'] = nome;
    m['cpf'] = cpf;
    m['done'] = done;

    return m;
  }
}

class TodoList {
  List<TodoItem> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class HomeCpf extends StatelessWidget {
  const HomeCpf({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifique se o CPF é verdadeiro'),
      ),
      body: ListView(
        children: <Widget>[
          CpfCab(),
          CpfForm(),
        ],
      ),
    );
  }
}

class CpfCab extends StatelessWidget {
  const CpfCab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        SizedBox(
          height: 10,
        ),
        const Image(
            image: NetworkImage(
                'data:image/png;base64,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')),
        SizedBox(
          height: 10,
        ),
        Text(
          'Informe seus dados',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoList list = new TodoList();
    final LocalStorage storage = new LocalStorage('local');
    bool initialized = false;
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Lista de usuários'),
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!initialized) {
                var items = storage.getItem('todos');
                print(items);
                if (items != null) {
                  list.items = List<TodoItem>.from(
                    (items as List).map(
                      (item) => TodoItem(
                          nome: item['nome'],
                          cpf: item['cpf'],
                          done: item['done']),
                    ),
                  );
                }

                initialized = true;
              }

              List<Widget> widgets = list.items.map((item) {
                return CheckboxListTile(
                  value: item.done,
                  title: Text('Nome: ' + item.nome + ' - CPF: ' + item.cpf),
                  selected: item.done,
                  onChanged: (_) {},
                );
              }).toList();

              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: widgets,
                      itemExtent: 50.0,
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}

class CpfForm extends StatefulWidget {
  const CpfForm({Key? key}) : super(key: key);

  @override
  _CpfFormState createState() => _CpfFormState();
}

class _CpfFormState extends State<CpfForm> {
  var _edNome = TextEditingController();
  var _edCPF = TextEditingController();
  final TodoList list = new TodoList();
  TextEditingController controller = new TextEditingController();

  final LocalStorage storage = new LocalStorage('local');
  String _mensagem = "";
  _addItem(String nome, String cpf) {
    setState(() {
      final item = new TodoItem(nome: nome, cpf: cpf, done: false);
      list.items.add(item);
      _saveToStorage();
    });
  }

  _saveToStorage() {
    storage.setItem('todos', list.toJSONEncodable());
  }

  @override
  Widget build(BuildContext context) {
    var items = storage.getItem('todos');

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edNome,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Nome',
            ),
          ),
          TextFormField(
            controller: _edCPF,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              icon: Icon(Icons.vertical_split),
              labelText: 'CPF',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              onPressed: () {
                String cpf = _edCPF.text;
                if (cpf.length == 11) {
                  bool ok1 = false;
                  bool ok2 = false;
                  String valido = 'NÃO É VÁLIDO!';
                  int calc1 = int.parse(cpf[0]) * 10 +
                      int.parse(cpf[1]) * 9 +
                      int.parse(cpf[2]) * 8 +
                      int.parse(cpf[3]) * 7 +
                      int.parse(cpf[4]) * 6 +
                      int.parse(cpf[5]) * 5 +
                      int.parse(cpf[6]) * 4 +
                      int.parse(cpf[7]) * 3 +
                      int.parse(cpf[8]) * 2;
                  double resto1 = calc1 * 10 % 11;
                  if (resto1 == 10) {
                    resto1 = 0;
                  }
                  if (resto1.toString() == cpf[9]) {
                    ok1 = true; //primeiro OK!!!!
                  }
                  int calc2 = int.parse(cpf[0]) * 11 +
                      int.parse(cpf[1]) * 10 +
                      int.parse(cpf[2]) * 9 +
                      int.parse(cpf[3]) * 8 +
                      int.parse(cpf[4]) * 7 +
                      int.parse(cpf[5]) * 6 +
                      int.parse(cpf[6]) * 5 +
                      int.parse(cpf[7]) * 4 +
                      int.parse(cpf[8]) * 3 +
                      int.parse(cpf[9]) * 2;
                  double resto2 = calc2 * 10 % 11;
                  if (resto2 == 10) {
                    resto2 = 0;
                  }
                  if (resto2.toString() == cpf[10]) {
                    ok2 = true; //segundo OK!!!!
                  }
                  if (ok1 && ok2) {
                    valido = 'É VÁLIDO!';
                  }

                  setState(() {
                    _mensagem = "${_edNome.text} seu CPF " + valido.toString();
                  });

                  _save();
                } else {
                  setState(() {
                    _mensagem = "CPF deve possuir 11 caractéres!!!";
                  });
                }
              },
              child: Text('Verificar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  )),
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
              child: Text('Ver lista',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _mensagem,
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    _addItem(_edNome.text, _edCPF.text);
    controller.clear();
  }
}
