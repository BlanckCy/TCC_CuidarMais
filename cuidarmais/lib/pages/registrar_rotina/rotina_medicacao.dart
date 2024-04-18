import 'package:cuidarmais/models/paciente.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class MedicacaoPage extends StatefulWidget {
  final Paciente paciente;

  const MedicacaoPage({Key? key, required this.paciente}) : super(key: key);

  @override
  State<MedicacaoPage> createState() => _MedicacaoPageState();
}

class _MedicacaoPageState extends State<MedicacaoPage> {
  bool _checkboxValue1 = false;
  bool _checkboxValue2 = false;
  bool _checkboxValue3 = false;
  bool _checkboxValue4 = false;
  bool _checkboxValue5 = false;
  bool _checkboxValue6 = false;
  bool _checkboxValue7 = false;
  bool _checkboxValue8 = false;
  bool _checkboxValue9 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ), // Adiciona espaço para acomodar a AppBar
          Container(
            padding: const EdgeInsets.all(25),
            color: Colors.white,
            child: Center(
              child: Text(
                "Rotina de Medicação",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Rotina da Manhã",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckboxListTile(
                  title: Text('Medicação 1'),
                  value: _checkboxValue1,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue1 = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Medicação 2'),
                  value: _checkboxValue2,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue2 = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Medicação 3'),
                  value: _checkboxValue3,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue3 = value!;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Rotina da Tarde",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckboxListTile(
                  title: Text('Medicação 1'),
                  value: _checkboxValue4,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue4 = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Medicação 2'),
                  value: _checkboxValue5,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue5 = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Medicação 3'),
                  value: _checkboxValue6,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue6 = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Rotina da Noite",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckboxListTile(
                  title: Text('Medicação 1'),
                  value: _checkboxValue7,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue7 = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Medicação 2'),
                  value: _checkboxValue8,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue8 = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Medicação 3'),
                  value: _checkboxValue9,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxValue9 = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
