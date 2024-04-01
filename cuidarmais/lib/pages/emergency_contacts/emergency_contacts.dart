import 'package:cuidarmais/models/contatoEmergencia.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/emergency_contacts_management/emergency_contacts_management.dart';
import 'package:flutter/material.dart';

class EmergencyContactsPage extends StatefulWidget {
  final Paciente paciente;

  const EmergencyContactsPage({Key? key, required this.paciente})
      : super(key: key);

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Contatoemergencia> contatos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarContatos(idpaciente: widget.paciente.idpaciente ?? 0);
  }

  Future<void> _carregarContatos({required int idpaciente}) async {
    try {
      var listarContatos =
          await Contatoemergencia().carregarContatos(idpaciente);
      setState(() {
        contatos = listarContatos;
        _isLoading = false;
      });
    } catch (error) {
      print('Erro ao carregar contatos de emergencia: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: Text('Erro ao carregar os contatos de emergência'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContactList(),
    );
  }

  Widget _buildContactList() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Contatos de Emergência',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Ação para chamar o bombeiro
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    'Bombeiros',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Ação para chamar a polícia
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.local_police,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    'Polícia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Ação para chamar o SAMU
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.local_hospital,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    'SAMU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmergencyContactsManagementPage(
                            paciente: widget.paciente,
                            idcontato_emergencia:
                                contatos[index].idcontato_emergencia,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 210, 228, 255),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(250, 50),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                        ),
                        Expanded(
                          child: Text(
                            contatos[index].nome ?? "Erro nome",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmergencyContactsManagementPage(
                      paciente: widget.paciente),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1C51A1),
              minimumSize: const Size(250, 50),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Adicionar Contato',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
