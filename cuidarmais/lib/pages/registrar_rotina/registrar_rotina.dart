import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/rotina.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_ativ_fisica.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_decubito.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_medicacao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_higiene.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_refeicao.dart';
import 'package:cuidarmais/pages/registrar_rotina/rotina_sinais_vitais.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';

class RegistrarRotinaPage extends StatefulWidget {
  const RegistrarRotinaPage({Key? key}) : super(key: key);

  @override
  State<RegistrarRotinaPage> createState() => _RegistrarRotinaPageState();
}

class _RegistrarRotinaPageState extends State<RegistrarRotinaPage> {
  late Paciente paciente = Paciente();

  @override
  void initState() {
    super.initState();
    _recuperarPaciente();
  }

  Future<void> _recuperarPaciente() async {
    final pacienteRecuperado =
        await PacienteSharedPreferences.recuperarPaciente();
    if (pacienteRecuperado != null) {
      setState(() {
        paciente = pacienteRecuperado;
      });
    } else {}
  }

  Future<void> _atualizarRotinaAtual() async {
    try {
      bool confirmacao = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmação'),
          content:
              const Text('Tem certeza que deseja finalizar a rotina atual?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );

      if (confirmacao) {
        bool atualizacaoSucesso = false;

        Rotina rotina = Rotina(
          realizado: true,
          idpaciente: paciente.idpaciente,
        );

        atualizacaoSucesso = await rotina.atualizar();

        showConfirmationDialog(
          context: context,
          title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
          message: atualizacaoSucesso
              ? 'A rotina foi finalizada!'
              : 'Houve um erro ao finalizar a rotina. Por favor, tente novamente.',
          onConfirm: () {},
        );
      }
    } catch (error) {
      print('Erro ao salvar os dados: $error');
      showConfirmationDialog(
        context: context,
        title: 'Erro',
        message: 'Erro ao salvar os dados.',
        onConfirm: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Qual rotina gostaria de registrar?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(
                  'Medicação',
                  Icons.medical_services_sharp,
                  const MedicacaoPage(
                    tipoCuidado: 5,
                  )),
              const SizedBox(height: 20),
              _buildButton(
                  'Sinais Vitais',
                  Icons.auto_graph_rounded,
                  const SinaisVitaisPage(
                    tipoCuidado: 2,
                  )),
              const SizedBox(height: 20),
              _buildButton(
                  'Refeições',
                  Icons.food_bank,
                  const RefeicaoPage(
                    tipoCuidado: 1,
                  )),
              const SizedBox(height: 20),
              _buildButton(
                  'Atividade Física',
                  Icons.accessibility_new,
                  const AtividadeFisicaPage(
                    tipoCuidado: 3,
                  )),
              const SizedBox(height: 20),
              _buildButton(
                  'Higiene',
                  Icons.shower,
                  RotinaHigienePage(
                    paciente: paciente,
                    tipoCuidado: 4,
                  )),
              const SizedBox(height: 20),
              _buildButton(
                'Mudança Decúbito',
                Icons.bedroom_child,
                const RotinaDecubitoPage(
                  tipoCuidado: 6,
                ),
              ),
              const SizedBox(height: 30),
              _buildButtonFinalizar(),
              const Text(
                'Ao finalizar a rotina não será mais possível alterar a rotina atual.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonFinalizar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          _atualizarRotinaAtual();
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 66, 141, 69),
          foregroundColor: Colors.white,
          minimumSize: const Size(250, 50),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle_rounded),
            SizedBox(width: 20),
            Text(
              'Finalizar Rotina',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
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
