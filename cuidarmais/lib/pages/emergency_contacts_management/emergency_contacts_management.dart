import 'package:cuidarmais/models/contatoEmergencia.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/pages/home/home.dart';
import 'package:cuidarmais/widgets/dialog.dart';
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
    contatoemergencia = Contatoemergencia(
      idcontato_emergencia: widget.idcontato_emergencia,
      idpaciente: widget.paciente.idpaciente,
    );

    _isLoading = false;
    if (widget.idcontato_emergencia != null) {
      _isLoading = true;
      _informacoesContato();
    }
  }

  Future<void> _informacoesContato() async {
    try {
      var informacoes = await contatoemergencia.carregarInformacoesContato();
      setState(() {
        infoContato = informacoes;
        nomeController.text = infoContato?.nome ?? '';
        parentescoController.text = infoContato?.parentesco ?? '';
        telefoneController.text = infoContato?.telefone ?? '';
        _isLoading = false;
      });
    } catch (error) {
      print('Erro ao carregar dados: $error');
      await showConfirmationDialog(
        context: context,
        title: 'Erro',
        message: 'Erro ao carregar os dados.',
        onConfirm: () {
          // Navigator.of(context).pop();
        },
      );
    }
  }

  Future<void> _atualizarDados() async {
    contatoemergencia.nome = nomeController.text;
    contatoemergencia.parentesco = parentescoController.text;
    contatoemergencia.telefone = telefoneController.text;

    bool atualizacaoSucesso = await contatoemergencia.atualizarDados();

    showConfirmationDialog(
      context: context,
      title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
      message: atualizacaoSucesso
          ? 'Os dados foram atualizados com sucesso!'
          : 'Houve um erro ao atualizar os dados. Por favor, tente novamente.',
      onConfirm: () {
        // Navigator.of(context).pop();
      },
    );
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

        showConfirmationDialog(
          context: context,
          title: resultado ? 'OK' : 'Erro',
          message: resultado
              ? 'O cadastro foi deletado com sucesso!'
              : 'Ocorreu um erro ao deletar o cadastro.',
          confirmButtonText: 'OK',
          onConfirm: () {
            if (resultado) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    paciente: widget.paciente,
                    selectedIndex: 2,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> _cadastrar() async {
    contatoemergencia.nome = nomeController.text;
    contatoemergencia.parentesco = parentescoController.text;
    contatoemergencia.telefone = telefoneController.text;

    bool atualizacaoSucesso = await contatoemergencia.cadastrar();

    showConfirmationDialog(
      context: context,
      title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
      message: atualizacaoSucesso
          ? 'O cadastro foi realizado com sucesso!'
          : 'Houve um erro ao realizar o cadastro. Por favor, tente novamente.',
      onConfirm: () {
        if (atualizacaoSucesso) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                paciente: widget.paciente,
                selectedIndex: 2,
              ),
            ),
          );
        }
      },
    );
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
