import 'package:cuidarmais/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/pages/PatientDataManagementPage/PatientDataManagementPage.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1C51A1),
        titleSpacing: 0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo-horizontal.png',
              height: 40,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Insira seu e-mail para recuperar a senha:',
                style: TextStyle(fontSize: 16),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xFF1C51A1),
                          ),
                          labelText: 'E-mail:',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Digite seu e-mail',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ],
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
      ),
    );
  }
}
