import 'package:cuidarmais/pages/registrar_rotina/rotina_medicacao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_ativ_fisica.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_higiene.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_refeicao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_sinais_vitais.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class RegistrarRotinaPage extends StatefulWidget {
  @override
  _RegistrarRotinaPageState createState() => _RegistrarRotinaPageState();
}

class _RegistrarRotinaPageState extends State<RegistrarRotinaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context)
                  .padding
                  .top), // Adiciona espaço para acomodar a AppBar
          Container(
            padding: const EdgeInsets.all(25),
            color: Colors.white,
            child: Center(
              child: Text(
                "Qual rotina gostaria de cadastrar?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 30),
          _buildButton(
              'Medicação', Icons.medical_services_sharp, MedicacaoPage()),
          SizedBox(height: 30),
          _buildButton(
              'Sinais Vitais', Icons.auto_graph_rounded, SinaisVitaisPage()),
          SizedBox(height: 30),
          _buildButton('Refeições', Icons.food_bank, RefeicaoPage()),
          SizedBox(height: 30),
          _buildButton('Atividade Física', Icons.accessibility_new,
              AtividadeFisicaPage()),
          SizedBox(height: 30),
          _buildButton('Higiene', Icons.shower, HigienePage()),
          // Adicione mais botões conforme necessário
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Widget destination) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0XFF1C51A1),
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
            SizedBox(width: 20),
            Text(
              text,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
