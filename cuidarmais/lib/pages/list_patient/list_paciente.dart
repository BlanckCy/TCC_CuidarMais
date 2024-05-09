import 'package:cuidarmais/models/cuidador.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/home/home.dart';
import 'package:cuidarmais/pages/sign_up/sign_up_paciente.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/services.dart';

class ListaPacientePage extends StatefulWidget {
  const ListaPacientePage({Key? key}) : super(key: key);

  @override
  State<ListaPacientePage> createState() => _ListaPacientePageState();
}

class _ListaPacientePageState extends State<ListaPacientePage> {
  List<Paciente> pacientes = [];
  bool _isLoading = true;
  late Cuidador cuidador = Cuidador();
  late Paciente paciente = Paciente();

  @override
  void initState() {
    super.initState();
    _recuperarCuidador();
  }

  Future<void> _recuperarCuidador() async {
    final cuidadorRecuperado = await CuidadorSharedPreferences.recuperar();
    if (cuidadorRecuperado != null) {
      setState(() {
        cuidador = cuidadorRecuperado;
      });
      paciente.idcuidador = cuidador.idcuidador;
      _carregarPacientes();
    } else {}
  }

  Future<void> _carregarPacientes() async {
    try {
      var listaPacientes = await paciente.carregarPacientes();
      setState(() {
        pacientes = listaPacientes;
        _isLoading = false;
      });
    } catch (error) {
      print('Erro ao carregar pacientes: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro ao carregar pacientes'),
          content: Text('$error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildPacientesList(),
      ),
    );
  }

  Widget _buildPacientesList() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpPacientePage(),
                ),
              );
            },
            icon: const Icon(Icons.person_add_alt_1),
            label: const Text('Cadastrar Paciente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF1C51A1),
              foregroundColor: Colors.white,
              minimumSize: const Size(250, 50),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Meus Pacientes',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    onPressed: () async {
                      await PacienteSharedPreferences.salvarPaciente(
                        pacientes[index],
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
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
                        const Icon(Icons.person),
                        const SizedBox(width: 8),
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
    );
  }

  Future<bool> _onBackPressed() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseja sair do aplicativo?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              SystemNavigator.pop();
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
    return shouldExit ?? false;
  }
}
