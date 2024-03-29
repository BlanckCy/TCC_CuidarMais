import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/principal/PrincipalPage.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:cuidarmais/widgets/customBottomBar.dart';

class HomePage extends StatefulWidget {
  final Paciente paciente;

  const HomePage({Key? key, required this.paciente}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

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
        return _buildRegistrarRotina();
      case 1:
        return PrincipalPage(paciente: widget.paciente,);
      case 2:
        return _buildBotaoEmergencia();
      default:
        return Container();
    }
  }

  Widget _buildRegistrarRotina() {
    return const Center(
      child: Text('Registrar Rotina'),
    );
  }

  Widget _buildBotaoEmergencia() {
    return const Center(
      child: Text('Botão Emergência'),
    );
  }
}
