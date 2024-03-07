import 'package:cuidarmais/models/cuidador.dart';
import 'package:cuidarmais/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/pages/sign_up/sign_up_cuidador.dart';
import 'package:cuidarmais/constants/custom_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool continueConnected = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Cuidador cuidador = Cuidador();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
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
                  "assets/logoTeste2.png",
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
                      ),
                    ),
                    TextFormField(
                      controller: senhaController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key_sharp,
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
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                children: [
                  Checkbox(
                    value: continueConnected,
                    onChanged: (newValue) {
                      setState(() {
                        continueConnected = newValue!;
                      });
                    },
                  ),
                  const Text(
                    "Continuar conectado?",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  print(emailController.text);
                  print(senhaController.text);
                  if (_formKey.currentState!.validate()) {
                    bool isValidLogin = await cuidador.isValid(emailController.text, senhaController.text);
                    if (isValidLogin) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('E-mail ou senha inválidos.'),
                        ),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 84, 109),
                    foregroundColor: Colors.white),
                child: const Text("Login"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  color: Color.fromARGB(255, 2, 84, 109),
                ),
              ),
              const Text(
                "Ainda não tem uma conta?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 84, 109), fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpCuidadorPage(),
                      ),
                    );
                  },
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
