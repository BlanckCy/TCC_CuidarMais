import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/list_patient/list_paciente.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class SignUpPacientePage extends StatefulWidget {
  final Paciente paciente;

  const SignUpPacientePage({Key? key, required this.paciente})
      : super(key: key);

  @override
  State<SignUpPacientePage> createState() => _SignUpPacientePageState();
}

class _SignUpPacientePageState extends State<SignUpPacientePage> {
  String _emailError = '';
  String _selectedGender = '';

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailResponsavelController =
      TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController nomeResponsavelController =
      TextEditingController();
  final TextEditingController idadeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Paciente paciente = Paciente();

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
                "Cadastro Paciente",
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
                        labelText: "Nome completo:",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Digite o nome do paciente",
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
                        paciente.nome = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o nome do paciente';
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
                        hintText: "Digite a idade do paciente",
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
                        paciente.idade = int.tryParse(value ?? '');
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite a idade do paciente';
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
                            value ?? 'Selecione o gênero do paciente',
                            style: const TextStyle(
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
                        hintText: 'Selecione o gênero do paciente',
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
                        paciente.genero = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione o gênero do paciente';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: nomeResponsavelController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "Nome do Responsável:",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Digite o nome completo do responsável",
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
                        paciente.nome_responsavel = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o nome do responsável';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailResponsavelController,
                      onChanged: (value) {
                        setState(() {
                          _emailError = paciente.validateEmail(value) ?? '';
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0XFF1C51A1),
                        ),
                        labelText: "E-mail do responsável:",
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: "Digite o e-mail do responsável",
                        hintStyle: const TextStyle(color: Colors.black),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        errorText: _emailError.isNotEmpty ? _emailError : null,
                      ),
                      onSaved: (value) {
                        paciente.email_responsavel = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o e-mail do responsável';
                        }
                        return null;
                      },
                    ),
                    /* DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                          generoController.text = newValue;
                        });
                      },
                      items: <String?>[
                        null,
                        'Cuidado Mínimo',
                        'Cuidado Intermediário',
                        'Cuidado Intensificado'
                      ].map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value ?? '',
                          child: Text(
                            value ?? 'Selecione o nível de cuidado',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.health_and_safety_outlined,
                          color: Color(0XFF1C51A1),
                        ),
                        hintText: 'Selecione o nível de cuidado',
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
                      onSaved: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione o nível de cuidado';
                        }
                        return null;
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              child: Center(
                                child: Text(
                                  'Informações sobre o nível de cuidado',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.info_outline),
                      color: Colors.blue,
                    ), */
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool resultado = await paciente
                        .cadastrar(widget.paciente.idcuidador ?? 0);
                    if (resultado) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Cadastro OK'),
                            content:
                                Text('O cadastro foi realizado com sucesso!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListaPacientePage(
                                        paciente: widget.paciente,
                                      ),
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
                            title: Text('Erro'),
                            content: Text(
                                'Erro ao criar cadastro. Tente novamente.'),
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
