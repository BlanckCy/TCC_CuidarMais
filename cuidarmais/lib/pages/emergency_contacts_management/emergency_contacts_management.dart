import 'package:cuidarmais/models/contatoEmergencia.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class EmergencyContactsManagementPage extends StatefulWidget {
  final Paciente paciente;
  final int? idcontato_emergencia;

  const EmergencyContactsManagementPage({
    Key? key,
    required this.paciente,
    this.idcontato_emergencia,
  }) : super(key: key);

  @override
  State<EmergencyContactsManagementPage> createState() =>
      _EmergencyContactsManagementPageState();
}

class _EmergencyContactsManagementPageState
    extends State<EmergencyContactsManagementPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Contatoemergencia? infoContato;
  bool _isLoading = false;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController parentescoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  late Contatoemergencia contatoemergencia = Contatoemergencia();

  @override
  void initState() {
    super.initState();
    contatoemergencia = Contatoemergencia();

    _isLoading = false;
    if (widget.idcontato_emergencia != null) {
      _isLoading = true;
      _informacoesContato(idcontato_emergencia: widget.idcontato_emergencia!);
    }
  }

  Future<void> _informacoesContato({required int idcontato_emergencia}) async {
    try {
      var informacoes = await Contatoemergencia()
          .carregarInformacoesContato(idcontato_emergencia);
      setState(() {
        infoContato = informacoes;
        nomeController.text = infoContato?.nome ?? '';
        parentescoController.text = infoContato?.parentesco ?? '';
        telefoneController.text = infoContato?.telefone ?? '';
        _isLoading = false;
      });
    } catch (error) {
      print('Erro ao carregar dados: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: Text('Erro ao carregar os dados.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContactDetails(),
    );
  }

  Widget _buildContactDetails() {
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
              "Dados do Contato",
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
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Contato:',
                      hintText: 'Digite o nome do contato de emergência',
                    ),
                    onSaved: (value) {
                      contatoemergencia.nome = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome do contato';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: parentescoController,
                    decoration: const InputDecoration(
                      labelText: 'Parentesco:',
                      hintText: 'Digite o parentesco do contato de emergência',
                    ),
                    onSaved: (value) {
                      contatoemergencia.parentesco = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o parentesco do contato';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: telefoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Telefone do Contato:',
                      hintText: 'Digite o telefone do contato de emergência',
                    ),
                    onSaved: (value) {
                      contatoemergencia.telefone = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o telefone do contato';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  bool resultado = await contatoemergencia
                      .cadastrar(widget.paciente.idpaciente ?? 0);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(resultado ? 'Cadastro OK' : 'Erro'),
                        content: Text(
                          resultado
                              ? 'O cadastro foi realizado com sucesso!'
                              : 'Ocorreu um erro ao realizar o cadastro.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              if (resultado) {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      paciente: widget.paciente,
                                      selectedIndex: 2,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C51A1),
              ),
              child: Text(
                infoContato != null ? 'Atualizar Contato' : 'Salvar Contato',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            if (infoContato != null)
              ElevatedButton(
                onPressed: () async {
                  bool resultado = await contatoemergencia
                      .deletarContatoEmergencia(infoContato?.idcontato_emergencia ?? 0);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(resultado ? 'OK' : 'Erro'),
                        content: Text(
                          resultado
                              ? 'O cadastro foi deletado com sucesso!'
                              : 'Ocorreu um erro ao realizar ao deletar cadastro.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              if (resultado) {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      paciente: widget.paciente,
                                      selectedIndex: 2,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Deletar Contato',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
