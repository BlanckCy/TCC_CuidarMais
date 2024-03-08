import 'package:flutter/material.dart';
import 'package:cuidarmais/pages/PatientDataManagementPage/PatientDataManagementPage.dart'; // Importe o arquivo PatientDataManagementPage.dart

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remover o botão de voltar padrão
        backgroundColor: Color.fromARGB(255, 24, 147, 189),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/TesteBar.png', // Caminho para o logotipo
                height: 40, // Altura do logotipo
              ),
            ),
            Text(
              'CUIDAR +', // Texto ao lado do logotipo
              style: TextStyle(color: Colors.white),
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
              'Insira seu e-mail para recuperar a senha:', // Instrução para o usuário
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Campo de entrada de e-mail
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20), // Margens personalizadas
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  prefixIcon: Icon(Icons.email_outlined,
                      color: Color.fromARGB(255, 2, 84,
                          109)), // Ícone de e-mail com cor personalizada
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Botão de envio
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar o e-mail de recuperação de senha
                // Aqui você implementaria a lógica para enviar o e-mail de recuperação
              },
              child: const Text('Recuperar Senha'),
            ),

            const SizedBox(height: 20), // Espaçamento entre elementos

            // Botão para gerenciar os dados do paciente
            ElevatedButton(
              onPressed: () {
                // Navegação para a tela de gerenciamento de dados do paciente
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientDataManagementPage()),
                );
              },
              child: const Text('Gerenciar Dados do Paciente'),
            ),
          ],
        ),
      ),
    );
  }
}
