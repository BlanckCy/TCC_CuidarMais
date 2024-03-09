import 'package:flutter/material.dart';

class PatientDataManagementPage extends StatefulWidget {
  const PatientDataManagementPage({Key? key}) : super(key: key);

  @override
  _PatientDataManagementPageState createState() =>
      _PatientDataManagementPageState();
}

class _PatientDataManagementPageState extends State<PatientDataManagementPage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1C51A1),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo-horizontal.png',
                height: 40,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dados do Paciente:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextFormField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Nome do Paciente',
                  hintText: 'Digite o nome do paciente',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Idade do Paciente',
                  hintText: 'Digite a idade do paciente',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Nome do Responsável',
                  hintText: 'Digite o nome do responsável',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'E-mail do Responsável',
                  hintText: 'Digite o e-mail do responsável',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                enabled: isEditing,
                decoration: InputDecoration(
                  labelText: 'Telefone do Responsável',
                  hintText: 'Digite o telefone do responsável',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Color(0xFF1C51A1),
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Color(0xFF1C51A1),
                    onPressed: () {
                      // Lógica para excluir todos os dados do paciente
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica para salvar as alterações
                },
                child: Text(
                  'Salvar Alterações',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1C51A1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
