import 'package:cuidarmais/models/contatoEmergencia.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmergencyContactsManagementPage extends StatefulWidget {
  final int? idcontato_emergencia;

  const EmergencyContactsManagementPage({
    Key? key,
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
  bool isEditing = false;

  String _selectParentesco = '';

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  final _telefoneMaskFormatter =
      MaskTextInputFormatter(mask: '(##) ####-####', filter: {
    "#": RegExp(r'[0-9]'),
  });

  late Contatoemergencia contatoemergencia = Contatoemergencia();
  late Paciente paciente = Paciente();

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
      });
      contatoemergencia.idcontato_emergencia = widget.idcontato_emergencia;
      contatoemergencia.idpaciente = paciente.idpaciente;

      _isLoading = false;
      if (widget.idcontato_emergencia != null) {
        _isLoading = true;
        _informacoesContato();
      } else {
        setState(() {
          isEditing = true;
        });
      }
    } else {}
  }

  Future<void> _informacoesContato() async {
    try {
      var informacoes = await contatoemergencia.carregarInformacoesContato();
      setState(() {
        infoContato = informacoes;
        nomeController.text = infoContato?.nome ?? '';
        _selectParentesco = infoContato?.parentesco ?? '';
        telefoneController.text = infoContato?.telefone ?? '';
        _isLoading = false;
      });
    } catch (error) {
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: 'Erro',
          message: 'Erro ao carregar os dados.',
          onConfirm: () {},
        );
      });
    }
  }

  Future<void> _atualizarDados() async {
    contatoemergencia.nome = nomeController.text;
    contatoemergencia.telefone = telefoneController.text;

    bool atualizacaoSucesso = await contatoemergencia.atualizarDados();

    Future.microtask(() {
      showConfirmationDialog(
        context: context,
        title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
        message: atualizacaoSucesso
            ? 'Os dados foram atualizados com sucesso!'
            : 'Houve um erro ao atualizar os dados. Por favor, tente novamente.',
        onConfirm: () {},
      );
    });
  }

  Future<void> _deletarDados() async {
    showConfirmationDialog(
      context: context,
      title: 'Confirmação',
      message: 'Deseja realmente deletar?',
      confirmButtonText: 'Sim',
      onCancel: () => Navigator.of(context).pop(),
      onConfirm: () async {
        contatoemergencia.idcontato_emergencia = widget.idcontato_emergencia;
        bool resultado = await contatoemergencia.deletarContatoEmergencia();

        Future.microtask(() {
          showConfirmationDialog(
            context: context,
            title: resultado ? 'OK' : 'Erro',
            message: resultado
                ? 'O cadastro foi deletado com sucesso!'
                : 'Ocorreu um erro ao deletar o cadastro.',
            confirmButtonText: 'OK',
            onConfirm: () {
              if (resultado) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                  arguments: 2,
                );
              }
            },
          );
        });
      },
    );
  }

  Future<void> _cadastrar() async {
    contatoemergencia.nome = nomeController.text;
    contatoemergencia.telefone = telefoneController.text;

    bool atualizacaoSucesso = await contatoemergencia.cadastrar();

    Future.microtask(() {
      showConfirmationDialog(
        context: context,
        title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
        message: atualizacaoSucesso
            ? 'O cadastro foi realizado com sucesso!'
            : 'Houve um erro ao realizar o cadastro. Por favor, tente novamente.',
        onConfirm: () {
          if (atualizacaoSucesso) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              '/home',
              arguments: 2,
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(hasPreviousRoute: true),
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
            Text(
              infoContato != null ? "Dados do Contato" : "Cadastro do Contato",
              style: const TextStyle(
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
                  AbsorbPointer(
                    absorbing:
                        !isEditing, // Desabilita o DropdownButtonFormField quando isEditing for falso
                    child: DropdownButtonFormField<String>(
                      value: _selectParentesco,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectParentesco = newValue!;
                        });
                      },
                      items: <String?>[
                        null,
                        'Pai',
                        'Mãe',
                        'Filho',
                        'Filha',
                        'Irmão',
                        'Irmã',
                        'Avô',
                        'Avó',
                        'Tio',
                        'Tia',
                        'Primo',
                        'Prima',
                        'Outro',
                      ].map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value ?? '',
                          child: Text(
                            value ?? 'Selecione o parentesco',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: !isEditing ? Colors.grey : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: 'Selecione o parentesco',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: !isEditing ? Colors.grey : Colors.black,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: !isEditing ? Colors.grey : Colors.black,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      menuMaxHeight: 200,
                      isExpanded: true,
                      onSaved: (value) {
                        contatoemergencia.parentesco = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione o parentesco';
                        }
                        return null;
                      },
                      onTap: () {
                        if (!isEditing) {
                          return;
                        }
                      },
                    ),
                  ),
                  TextFormField(
                    enabled: isEditing,
                    controller: telefoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [_telefoneMaskFormatter],
                    decoration: const InputDecoration(
                      labelText: 'Telefone do Contato:',
                      hintText: '(XX) XXXXX-XXXX',
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
                    onChanged: (text) {
                      if (text.length >= 14) {
                        _telefoneMaskFormatter.updateMask(
                            mask: '(##) #####-####');
                      } else {
                        _telefoneMaskFormatter.updateMask(
                            mask: '(##) ####-####');
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (infoContato != null)
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
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (infoContato != null) {
                    _atualizarDados();
                  } else {
                    _cadastrar();
                  }
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
                  _deletarDados();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 208, 20, 20),
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
