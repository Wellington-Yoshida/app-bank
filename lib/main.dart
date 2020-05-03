import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());


class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTranferencia(),
      ),
    );
  }
}


class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criando transferencia')
      ),
        body: Column(
          children: <Widget>[
            Editor(controller: _controllerNumeroConta, rotulo: 'Número da Conta', dica: '0000',),
            Editor(controller: _controllerValor, rotulo: 'Valor', dica: '0.00', icone: Icons.monetization_on,),
            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        )
    );
  }

  void _criaTransferencia(BuildContext context) {
    final transferencia = Transferencia(double.tryParse(_controllerValor.text), int.tryParse(_controllerNumeroConta.text));
    Navigator.pop(context, transferencia);
  }

}

class Editor extends StatelessWidget {

  final TextEditingController controller;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controller, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}


class ListaTranferencia extends StatefulWidget {

  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
  
}

class ListaTransferenciaState extends State<ListaTranferencia> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          return ItemTransferencia(widget._transferencias[indice]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRealizada){
            widget._transferencias.add(transferenciaRealizada);
          });
        },
      ),
    );
  }

}

class ItemTransferencia extends StatelessWidget {

  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(this._transferencia._valor.toString()),
          subtitle: Text(this._transferencia._numeroConta.toString()),
        )
    );
  }
}

class Transferencia {

  final double _valor;
  final int _numeroConta;

  Transferencia(this._valor, this._numeroConta);
}