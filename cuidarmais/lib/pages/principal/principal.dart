import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/registrarPonto/registrarPonto.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _HomePageState();
}

class _HomePageState extends State<PrincipalPage> {
  late Paciente paciente = Paciente();
  bool _isLoading = true;

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
        _isLoading = false;
      });
    } else {}
  }

  Widget buildCustomButton(IconData icon, String text, Color color, String rota,
      [int? selectedIndex]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        onPressed: () {
          if (selectedIndex != null) {
            Navigator.pop(context);
          }
          Navigator.pushNamed(
            context,
            '/$rota',
            arguments: selectedIndex ?? 0,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(250, 50),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 25),
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildPrincipalWidget(),
    );
  }

  Widget _buildPrincipalWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileButton(),
            const Divider(),
            const Text(
              'Clique sobre a data atual para registrar o ponto',
              style: TextStyle(fontSize: 14),
            ),
            RegistrarPontoPage(
              paciente: paciente,
            ),
            const SizedBox(height: 20),
            buildCustomButton(
              Icons.local_hospital,
              'SOS Emergência',
              const Color.fromARGB(255, 208, 20, 20),
              'home',
              2,
            ),
            const SizedBox(height: 20),
            buildCustomButton(
              Icons.book,
              'Registrar Rotina',
              const Color.fromARGB(255, 49, 89, 149),
              'home',
              0,
            ),
            const SizedBox(height: 20),
            buildCustomButton(
              Icons.calendar_month,
              'Calendário Escala',
              const Color.fromARGB(255, 49, 89, 149),
              'escala',
            ),
            const SizedBox(height: 20),
            buildCustomButton(
              Icons.receipt_long_sharp,
              'Relatório',
              const Color.fromARGB(255, 49, 89, 149),
              'relatorioRotina',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileButton() {
    IconData genderIcon = Icons.person_outline;
    if (paciente.genero == 'F') {
      genderIcon = Icons.person_2_outlined;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/dadosPaciente',
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 72, 128, 212),
              radius: 30,
              child: Icon(
                genderIcon,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              paciente.nome ?? 'Nome Paciente',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
