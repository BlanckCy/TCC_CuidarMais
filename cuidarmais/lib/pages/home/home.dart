import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/emergency/emergency_contacts.dart';
import 'package:cuidarmais/pages/principal/principal.dart';
import 'package:cuidarmais/pages/registrar_rotina/registrar_rotina.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:cuidarmais/widgets/customBottomBar.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;

  const HomePage({
    Key? key,
    this.selectedIndex = 1,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;
  late Paciente paciente = Paciente();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasPreviousRoute: true,
        tohome: _selectedIndex != 1,
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const RegistrarRotinaPage();
      case 1:
        return const PrincipalPage();
      case 2:
        return const EmergencyContactsPage();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
