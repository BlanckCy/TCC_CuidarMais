import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/emergency/emergency_contacts.dart';
import 'package:cuidarmais/pages/principal/principal.dart';
import 'package:cuidarmais/pages/registrar_rotina/registrar_rotina.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:cuidarmais/widgets/customBottomBar.dart';

class HomePage extends StatefulWidget {
  final Paciente paciente;
  final int selectedIndex;

  const HomePage({
    Key? key,
    required this.paciente,
    this.selectedIndex = 1,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
        return RegistrarRotinaPage(paciente: widget.paciente);
      case 1:
        return PrincipalPage(paciente: widget.paciente);
      case 2:
        return EmergencyContactsPage(paciente: widget.paciente);
      default:
        return Container();
    }
  }
}
