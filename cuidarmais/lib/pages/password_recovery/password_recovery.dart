import 'package:flutter/material.dart';

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperação de Senha'), // Título da página
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Insira seu e-mail para recuperar a senha:', // Instrução para o usuário
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Campo de entrada de e-mail
            TextFormField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre elementos

            // Botão de envio
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar o e-mail de recuperação de senha
                // Aqui você implementaria a lógica para enviar o e-mail de recuperação
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
