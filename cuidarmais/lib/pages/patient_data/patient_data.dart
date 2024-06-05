import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/list_patient/list_paciente.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class PatientDataPage extends StatefulWidget {
  const PatientDataPage({Key? key}) : super(key: key);

  @override
  State<PatientDataPage> createState() => _PatientDataPage();
}

class _PatientDataPage extends State<PatientDataPage> {
  bool _isLoading = true;
  bool isEditing = false;
  late Paciente paciente = Paciente();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _recuperarPaciente();
  }

  Future<void> _recuperarPaciente() async {
    final pacienteRecuperado =
        await PacienteSharedPreferences.recuperarPaciente();
    if (pacienteRecuperado != null) {
      setState(() {
        paciente = pacienteRecuperado;
        _isLoading = false;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(hasPreviousRoute: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDadosPaciente(),
    );
  }

  Widget _buildDadosPaciente() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Dados do Paciente",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    enabled: isEditing,
                    initialValue: paciente.nome ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Nome do Paciente',
                      hintText: 'Digite o nome do paciente',
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
                    enabled: isEditing,
                    keyboardType: TextInputType.number,
                    initialValue: paciente.idade?.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Idade do Paciente',
                      hintText: 'Digite a idade do paciente',
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
                  TextFormField(
                    enabled: isEditing,
                    initialValue: paciente.genero,
                    decoration: const InputDecoration(
                      labelText: 'Gênero do Paciente',
                      hintText: 'Digite o gênero do paciente',
                    ),
                    onSaved: (value) {
                      paciente.genero = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite o gênero do paciente';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    enabled: isEditing,
                    initialValue: paciente.nome_responsavel ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Nome do Responsável',
                      hintText: 'Digite o nome do responsável',
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
                    enabled: isEditing,
                    initialValue: paciente.email_responsavel,
                    decoration: const InputDecoration(
                      labelText: 'E-mail do Responsável',
                      hintText: 'Digite o e-mail do responsável',
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Editar'),
                    ],
                  ),
                  color: const Color(0xFF1C51A1),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Map<String, dynamic> itens = await paciente.salvarDados();
                  bool resposta = itens['resposta'];
                  var dadosPaciente = itens['dados'];
                  Future.microtask(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Status da operação'),
                        content: Text(resposta
                            ? 'Dados salvos com sucesso!'
                            : 'Erro ao salvar os dados.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              if (resposta) {
                                await PacienteSharedPreferences.salvarPaciente(
                                  Paciente.fromJson(dadosPaciente),
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C51A1),
              ),
              child: const Text(
                'Salvar Alterações',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            /* ElevatedButton(
              onPressed: () async {
                bool confirmacao = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar exclusão'),
                    content: const Text(
                        'Tem certeza que deseja deletar este paciente?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Confirmar'),
                      ),
                    ],
                  ),
                );

                if (confirmacao == true) {
                  bool resposta =
                      await paciente.deletarPaciente(paciente.idpaciente ?? 0);
                  Future.microtask(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Status da operação'),
                        content: Text(resposta
                            ? 'Paciente Deletado!'
                            : 'Erro ao deletar o paciente.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (resposta) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ListaPacientePage(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 208, 20, 20),
              ),
              child: const Text(
                'Deletar Paciente',
                style: TextStyle(color: Colors.white),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
