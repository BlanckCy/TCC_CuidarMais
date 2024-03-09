import 'package:flutter/material.dart';
import 'package:cuidarmais/pages/PatientDataManagementPage/PatientDataManagementPage.dart';

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1C51A1), // Alterando a cor do AppBar para #1C51A1
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/logo-horizontal.png', // Alterando o caminho do logotipo
                  height: 40,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Insira seu e-mail para recuperar a senha:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  prefixIcon: Icon(Icons.email_outlined,
                      color: Color.fromARGB(255, 2, 84, 109)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Lógica para enviar o e-mail de recuperação de senha
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1C51A1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Recuperar Senha'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientDataManagementPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1C51A1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Gerenciar Dados do Paciente'),
            ),
          ],
        ),
      ),
    );
  }
}
