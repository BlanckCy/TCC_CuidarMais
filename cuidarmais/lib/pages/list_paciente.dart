// arquivo signup.dart completo

import 'package:cuidarmais/pages/PatientDataManagementPage/PatientDataManagementPage.dart';
import 'package:cuidarmais/pages/sign_up/sign_up_paciente.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';

class ListaPacientePage extends StatefulWidget {
  final Paciente paciente;

  const ListaPacientePage({Key? key, required this.paciente}) : super(key: key);
  @override
  State<ListaPacientePage> createState() => _ListaPacientePageState();
}

class _ListaPacientePageState extends State<ListaPacientePage> {
  List<Paciente> pacientes = [];

  Paciente paciente = Paciente();

  @override
  void initState() {
    super.initState();
    _carregarPacientes(idcuidador: widget.paciente.idcuidador ?? 0);
  }

  Future<void> _carregarPacientes({required int idcuidador}) async {
    try {
      var listaPacientes = await Paciente().carregarPacientes(idcuidador);
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
      appBar: const CustomAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPacientePage(
                      paciente: widget.paciente,
                    ),
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
            SizedBox(height: 30),
            Text(
              'Meus Pacientes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 210, 228, 255),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientDataManagementPage(
                              paciente: pacientes[index],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Alinha os ícones à esquerda
                        children: <Widget>[
                          Icon(Icons.person), // Ícone
                          SizedBox(
                              width: 8), // Espaçamento entre o ícone e o texto
                          Expanded(
                            child: Text(
                              pacientes[index].nome ?? "Erro nome",
                            ),
                          ),
                        ],
                      ),
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
