import 'package:cuidarmais/models/cuidador.dart';
import 'package:cuidarmais/pages/password_recovery/password_recovery.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/constants/custom_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool _continueConnected = false;
  bool _mostrarSenha = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Cuidador cuidador = Cuidador();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors().getBackTopColor(),
                CustomColors().getBackBottomColor()
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 7,
                ),
                child: Image.asset(
                  "assets/logo-vertical.png",
                  height: 200,
                ),
              ),
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0XFF1C51A1),
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite seu e-mail';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: senhaController,
                      obscureText: !_mostrarSenha,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.vpn_key_sharp,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "Senha:",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: "Digite sua senha",
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _mostrarSenha
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0XFF1C51A1),
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite sua senha';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordRecoveryPage(),
                    ),
                  );
                },
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 40),
              /* Row(
                children: [
                  Checkbox(
                    value: _continueConnected,
                    onChanged: (newValue) {
                      setState(() {
                        _continueConnected = newValue!;
                      });
                    },
                  ),
                  const Text(
                    "Continuar conectado?",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ), */
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    Map<String, dynamic> loginResult = await cuidador.isValid(
                        emailController.text, senhaController.text);
                    if (loginResult['resposta'] == true) {
                      cuidador = Cuidador.fromJson(loginResult['dados']);
                      await CuidadorSharedPreferences.salvar(cuidador);
                      Future.microtask(() {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/listaPacientes',
                          (route) => false,
                        );
                      });
                    } else {
                      Future.microtask(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('E-mail ou senha inválidos.'),
                          ),
                        );
                      });
                    }
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0XFF1C51A1),
                    foregroundColor: Colors.white),
                child: const Text("Login"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  color: Color(0XFF1C51A1),
                ),
              ),
              const Text(
                "Ainda não tem uma conta?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0XFF1C51A1), fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/cadastrarCuidador',
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0XFF1C51A1),
                  ),
                  child: const Text("Cadastre-se"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
