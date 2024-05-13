import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/rotina.dart';
import 'package:cuidarmais/models/tipoCuidado/mudancadecubito.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:intl/intl.dart';

class RotinaDecubitoPage extends StatefulWidget {
  final int tipoCuidado;

  const RotinaDecubitoPage({Key? key, required this.tipoCuidado})
      : super(key: key);

  @override
  State<RotinaDecubitoPage> createState() => _RotinaDecubitoPageState();
}

class _RotinaDecubitoPageState extends State<RotinaDecubitoPage> {
  Map<String, String?> rotinaDecubito = {};

  List<Map<String, String?>> _selectedTasks = [];
  bool _isLoading = true;

  late MudancaDecubito mudancaDecubito = MudancaDecubito();
  late Rotina rotina = Rotina();

  List<Rotina> listaRotina = [];

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
      _carregarInformacoes();
    } else {}
  }

  Future<List<Rotina>> _validarRotina() async {
    try {
      Rotina rotina = Rotina(
        idpaciente: paciente.idpaciente,
        tipo_cuidado: widget.tipoCuidado,
        cuidado: 'Mudança Decúbito',
        realizado: false,
      );

      listaRotina = await rotina.carregar();

      if (listaRotina.isEmpty) {
        bool cadastrado = await rotina.cadastrar();
        if (cadastrado) {
          listaRotina = await rotina.carregar();
        }
      }
      return listaRotina;
    } catch (error) {
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: 'Erro',
          message: 'Erro ao carregar informações da rotina',
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      });
      return [];
    }
  }

  Future<void> _carregarInformacoes() async {
    try {
      mudancaDecubito.idpaciente = paciente.idpaciente;

      listaRotina = await _validarRotina();

      mudancaDecubito.idrotina = listaRotina[0].idrotina;

      List<MudancaDecubito> listaCuidado = await mudancaDecubito.carregar();

      setState(() {
        _selectedTasks = listaCuidado
            .map(
                (mudanca) => {'mudanca': mudanca.mudanca, 'hora': mudanca.hora})
            .toList();
        _isLoading = false;
      });

      print("aqui $_selectedTasks");

      if (_selectedTasks.isEmpty) {
        _addTaskRow();
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: 'Erro',
          message: 'Erro ao carregar informações da rotina',
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      });
    }
  }

  Future<void> _salvarInformacoes() async {
    try {
      bool atualizacaoSucesso = false;
      for (var rotina in rotinaDecubito.entries) {
        MudancaDecubito mudancaDecubito = MudancaDecubito(
          mudanca: rotina.key,
          hora: rotina.value,
          idpaciente: paciente.idpaciente,
          idrotina: listaRotina[0].idrotina,
        );

        atualizacaoSucesso = await mudancaDecubito.cadastrar();
      }
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
          message: atualizacaoSucesso
              ? 'As informações foram salvas com sucesso!'
              : 'Houve um erro ao salvar os dados. Por favor, tente novamente.',
          onConfirm: () {
            if (atualizacaoSucesso) {
              Navigator.of(context).pop();
            }
          },
        );
      });
    } catch (error) {
      print('Erro ao salvar os dados: $error');
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: 'Erro',
          message: 'Erro ao salvar os dados.',
          onConfirm: () {},
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildMudancaDecubitoList(),
    );
  }

  Widget _buildMudancaDecubitoList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitle(),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                    _selectedTasks.length,
                    (index) => _buildTaskRow(index),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: _buildButtonsSection(),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Rotina de Mudança de Decúbito",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTaskRow(int index) {
    Map<String?, String?> task = _selectedTasks[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Mudança',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Horário',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: task['mudanca'] == null
                    ? DropdownButtonFormField<String>(
                        value: task['mudanca'],
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue != "") {
                              task['mudanca'] = newValue;
                            }
                          });
                        },
                        items: <String?>[
                          null,
                          'Decúbito Dorsal (ou Supino)',
                          'Decúbito Lateral Esquerdo',
                          'Decúbito Lateral Direito',
                          'Decúbito Ventral (ou Prono)',
                          'Posição de Trendelenburg',
                          'Posição de Fowler',
                          'Posição de Sims',
                          'Posição de Litotomia'
                        ].map<DropdownMenuItem<String>>((String? value) {
                          return DropdownMenuItem<String>(
                            value: value ?? '',
                            child: Text(
                              value ?? 'Selecione a mudança',
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          hintText: 'Selecione a mudança',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        menuMaxHeight: 200,
                        isExpanded: true,
                      )
                    : Text(
                        task['mudanca']!,
                        style: const TextStyle(fontSize: 14),
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: task['hora'] != null
                          ? null
                          : () async {
                              final selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                setState(() {
                                  task['hora'] = _formatTime(selectedTime);
                                  if (task['mudanca'] != null) {
                                    rotinaDecubito[task['mudanca']!] =
                                        _formatTime(selectedTime);
                                  }
                                });
                              }
                            },
                      icon: const Icon(Icons.access_time),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        task['hora'] ?? '00:00',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 1, color: Colors.black),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildButton("Adicionar Mudança", _addTaskRow),
        const SizedBox(height: 10),
        _buildButton("Salvar", _salvarInformacoes),
      ],
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFF1C51A1),
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }

  String _formatTime(TimeOfDay? time) {
    if (time != null) {
      final now = DateTime.now();
      final DateTime selectedTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      return DateFormat.Hm().format(selectedTime);
    } else {
      return '';
    }
  }

  void _addTaskRow() {
    setState(() {
      _selectedTasks.add({'mudanca': null, 'hora': null});
    });
  }
}
