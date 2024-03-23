import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';

class SignUpPacientePage extends StatefulWidget {
  const SignUpPacientePage({Key? key});

  @override
  State<SignUpPacientePage> createState() => _SignUpPacientePageState();
}

class _SignUpPacientePageState extends State<SignUpPacientePage> {
  List<Paciente> pacientes = [];

  @override
  void initState() {
    super.initState();
    _carregarPacientes(); // Chamando a função corretamente
  }

  Future<void> _carregarPacientes() async {
    try {
      var listaPacientes = await Paciente()
          .carregarPacientes(1); // Carregar pacientes assincronamente
      setState(() {
        pacientes = listaPacientes;
      });
    } catch (error) {
      print('Erro ao carregar pacientes: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro ao carregar pacientes'),
          content: Text('$error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Adicione o código para lidar com o pressionamento do botão aqui
              },
              child: Text('Botão Antes da Lista'),
            ),
            SizedBox(height: 16), // Espaçamento entre o botão e a lista
            Expanded(
              child: ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        // _handlePacienteButtonPress(pacientes[index].idPaciente);
                      },
                      child: Text(pacientes[index].nome ?? " Erro nome"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
