// arquivo signup.dart completo

import 'package:cuidarmais/pages/sign_up/sign_up_paciente.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';

class ListaPacientePage extends StatefulWidget {
  const ListaPacientePage({Key? key});

  @override
  State<ListaPacientePage> createState() => _ListaPacientePageState();
}

class _ListaPacientePageState extends State<ListaPacientePage> {
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
      appBar: CustomAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            SizedBox(height: 16), // Espaçamento entre o texto e o botão
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPacientePage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0XFF1C51A1),
                foregroundColor: Colors.white,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Alinha o texto ao centro
                children: <Widget>[
                  Icon(Icons.person_add_alt_1), // Ícone
                  SizedBox(width: 20), // Espaçamento entre o ícone e o texto
                  Flexible(
                    child: Text(
                      'Cadastrar Paciente',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              'MEUS PACIENTES',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 63, 81, 181)),
            ),
            SizedBox(height: 16),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Alinha os ícones à esquerda
                            children: <Widget>[
                              Icon(Icons.person), // Ícone
                              SizedBox(
                                  width:
                                      8), // Espaçamento entre o ícone e o texto
                              Text(pacientes[index].nome ?? " Erro nome"),
                            ])),
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
