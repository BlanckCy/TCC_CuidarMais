import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_medicacao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_ativ_fisica.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_higiene.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_refeicao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_sinais_vitais.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class RegistrarRotinaPage extends StatefulWidget {
  final Paciente paciente;

  const RegistrarRotinaPage({Key? key, required this.paciente})
      : super(key: key);

  @override
  State<RegistrarRotinaPage> createState() => _RegistrarRotinaPageState();
}

class _RegistrarRotinaPageState extends State<RegistrarRotinaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Qual rotina gostaria de registrar?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Medicação', Icons.medical_services_sharp,
                      MedicacaoPage()),
                  const SizedBox(height: 30),
                  _buildButton('Sinais Vitais', Icons.auto_graph_rounded,
                      SinaisVitaisPage()),
                  const SizedBox(height: 30),
                  _buildButton(
                      'Refeições',
                      Icons.food_bank,
                      RefeicaoPage(
                        paciente: widget.paciente,
                        tipoCuidado: 1,
                      )),
                  const SizedBox(height: 30),
                  _buildButton('Atividade Física', Icons.accessibility_new,
                      AtividadeFisicaPage()),
                  const SizedBox(height: 30),
                  _buildButton('Higiene', Icons.shower, HigienePage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
          minimumSize: const Size(250, 50),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Text(
              text,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
