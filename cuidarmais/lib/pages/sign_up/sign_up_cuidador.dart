import 'package:cuidarmais/models/cuidador.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/constants/custom_colors.dart';

class SignUpCuidadorPage extends StatefulWidget {
  const SignUpCuidadorPage({super.key});

  @override
  State<SignUpCuidadorPage> createState() => _SignUpCuidadorPageState();
}

class _SignUpCuidadorPageState extends State<SignUpCuidadorPage> {
  bool _mostrarSenha = false;
  String _emailError = '';
  String _senhaError = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Cuidador cuidador = Cuidador();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors().getBackBottomColor(),
                CustomColors().getBackTopColor()
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Cadastro",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 2, 84, 109),
                        ),
                        labelText: "Nome:",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Digite seu nome completo",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _emailError = cuidador.validateEmail(value) ?? '';
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color.fromARGB(255, 2, 84, 109),
                        ),
                        labelText: "E-mail:",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Digite seu e-mail",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        errorText: _emailError.isNotEmpty ? _emailError : null,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Color.fromARGB(255, 2, 84, 109),
                        ),
                        labelText: "Celular:",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "(11) 99999-9999",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _senhaError = cuidador.validateSenha(value) ?? '';
                        });
                      },
                      obscureText: !_mostrarSenha,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.key_sharp,
                          color: Color.fromARGB(255, 2, 84, 109),
                        ),
                        labelText: "Senha:",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Digite sua senha",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _mostrarSenha
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromARGB(255, 2, 84, 109),
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                        errorText: _senhaError.isNotEmpty ? _senhaError : null,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cadastre-se"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
