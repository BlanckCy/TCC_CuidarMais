import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/home/home.dart';
import 'package:cuidarmais/pages/patient_data/patient_data.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _HomePageState();
}

class _HomePageState extends State<PrincipalPage> {
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

  Widget buildCustomButton(IconData icon, String text, Color color,
      Widget Function(BuildContext) onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: onPressed,
            ),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileButton(),
            const Divider(),
            const SizedBox(height: 20),
            buildCustomButton(
              Icons.book,
              'Registrar Rotina',
              const Color(0xFF1C51A1),
              (context) => const HomePage(
                selectedIndex: 0,
              ),
            ),
            const SizedBox(height: 20),
            buildCustomButton(
              Icons.local_hospital,
              'SOS Emergência',
              Colors.red,
              (context) => const HomePage(
                selectedIndex: 2,
              ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PatientDataPage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
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
