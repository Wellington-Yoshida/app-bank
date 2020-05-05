import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }

}

class FormularioTransferenciaState extends State<FormularioTransferencia> {

  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Criando transferencia')
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(controller: _controllerNumeroConta, rotulo: 'Número da Conta', dica: '0000',),
              Editor(controller: _controllerValor, rotulo: 'Valor', dica: '0.00', icone: Icons.monetization_on,),
              RaisedButton(
                child: Text('Confirmar'),
                onPressed: () => _criaTransferencia(context),
              ),
            ],
          ),
        )
    );
  }

  void _criaTransferencia(BuildContext context) {
    final transferencia = Transferencia(double.tryParse(_controllerValor.text), int.tryParse(_controllerNumeroConta.text));
    Navigator.pop(context, transferencia);
  }

}
