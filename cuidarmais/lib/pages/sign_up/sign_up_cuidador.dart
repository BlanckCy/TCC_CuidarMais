import 'package:cuidarmais/models/cuidador.dart';
import 'package:cuidarmais/pages/login/login.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class SignUpCuidadorPage extends StatefulWidget {
  const SignUpCuidadorPage({super.key});

  @override
  State<SignUpCuidadorPage> createState() => _SignUpCuidadorPageState();
}

class _SignUpCuidadorPageState extends State<SignUpCuidadorPage> {
  bool _mostrarSenha = false;
  String _emailError = '';
  String _senhaError = '';
  String _selectedGender = '';

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Cuidador cuidador = Cuidador();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Cadastro Cuidador",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: nomeController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "Nome:",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Digite seu nome completo",
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
                        ),
                      ),
                      onSaved: (value) {
                        cuidador.nome = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite seu nome';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: idadeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "Idade:",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Digite sua idade",
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
                        ),
                      ),
                      onSaved: (value) {
                        cuidador.idade = int.tryParse(value ?? '');
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite sua idade';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                          generoController.text = newValue;
                        });
                      },
                      items: <String?>[null, 'Feminino', 'Masculino', 'Outro']
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value ?? '',
                          child: Text(
                            value ?? 'Selecione seu gênero',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_pin_outlined,
                          color: Color(0XFF1C51A1),
                        ),
                        hintText: 'Selecione seu gênero',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      onSaved: (value) {
                        cuidador.genero = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione seu gênero';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: telefoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "Celular:",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "(11) 99999-9999",
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
                        ),
                      ),
                      onSaved: (value) {
                        cuidador.telefone = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite seu número';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      onChanged: (value) {
                        setState(() {
                          _emailError = cuidador.validateEmail(value) ?? '';
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "E-mail:",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Digite seu e-mail",
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
                        ),
                        errorText: _emailError.isNotEmpty ? _emailError : null,
                      ),
                      onSaved: (value) {
                        cuidador.email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite seu e-mail';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: senhaController,
                      onChanged: (value) {
                        setState(() {
                          _senhaError = cuidador.validateSenha(value) ?? '';
                        });
                      },
                      obscureText: !_mostrarSenha,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.key_sharp,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "Senha:",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Digite sua senha",
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
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _mostrarSenha
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0XFF1C51A1),
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                        errorText: _senhaError.isNotEmpty ? _senhaError : null,
                      ),
                      onSaved: (value) {
                        cuidador.senha = value;
                      },
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
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool resultado = await cuidador.cadastrar();
                    if (resultado) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Cadastro OK'),
                            content:
                                Text('Seu cadastro foi realizado com sucesso!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Atenção'),
                            content:
                                Text('O cadastro com este e-mail já existe.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0XFF1C51A1),
                ),
                child: const Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
