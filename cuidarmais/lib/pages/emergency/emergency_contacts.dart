import 'package:cuidarmais/models/contatoEmergencia.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Contatoemergencia> contatos = [];
  bool _isLoading = true;

  late Paciente paciente = Paciente();
  late Contatoemergencia contatoemergencia = Contatoemergencia();

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
      contatoemergencia.idpaciente = paciente.idpaciente;
      _carregarContatos();
    } else {}
  }

  Future<void> _carregarContatos() async {
    try {
      var listarContatos = await contatoemergencia.carregarContatos();
      setState(() {
        contatos = listarContatos;
        _isLoading = false;
      });
    } catch (error) {
      Future.microtask(() {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: const Text('Erro ao carregar os contatos de emergência'),
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: 1,
        );
        return false;
      },
      child: Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildContactList(),
      ),
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
              // _fazerChamada('193');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 208, 20, 20),
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
              // _fazerChamada('190');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 47, 48, 50),
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
              // _fazerChamada('192');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 29, 131, 214),
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
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
          const SizedBox(height: 8),
          const Text(
            'Principais Contatos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/gerenciarContatos',
                        arguments: contatos[index].idcontato_emergencia,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 164, 197, 248),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(250, 50),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.person),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                contatos[index].nome ?? "Erro nome",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                contatos[index].telefone ?? "Erro telefone",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
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
              Navigator.pushNamed(
                context,
                '/gerenciarContatos',
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

  /* void _fazerChamada(String phoneNumber) async {
    Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  } */
}
