import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/tipoCuidado/higiene.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:intl/intl.dart';

class RotinaHigienePage extends StatefulWidget {
  final Paciente paciente;
  final int tipoCuidado;

  const RotinaHigienePage(
      {Key? key, required this.paciente, required this.tipoCuidado})
      : super(key: key);

  @override
  State<RotinaHigienePage> createState() => _RotinaHigienePageState();
}

class _RotinaHigienePageState extends State<RotinaHigienePage> {
  Map<String, String?> rotinaDecubito = {};

  List<Map<String, String?>> _selectedTasks = [];
  final List<String?> _taskOptions = [
    null,
    'Banho',
    'Corte das Unhas',
    'Troca de Fralda'
  ];
  bool _isLoading = true;

  late Higiene higiene = Higiene();

  @override
  void initState() {
    super.initState();
    _carregarInformacoes();
  }

  Future<void> _carregarInformacoes() async {
    try {
      String dataFormatada = DateFormat('yyyy-MM-dd').format(DateTime.now());
      higiene.idpaciente = widget.paciente.idpaciente;
      List<Higiene> listaCuidado = await higiene.carregar(dataFormatada);

      setState(() {
        _selectedTasks = listaCuidado
            .map((tarefa) => {'tarefa': tarefa.tarefa, 'hora': tarefa.hora})
            .toList();
        _isLoading = false;
      });

      if (_selectedTasks.isEmpty) {
        _addTaskRow();
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      showConfirmationDialog(
        context: context,
        title: 'Erro',
        message: 'Erro ao carregar informações da rotina',
        onConfirm: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  Future<void> _salvarInformacoes() async {
    try {
      bool atualizacaoSucesso = false;
      for (var rotina in rotinaDecubito.entries) {
        Higiene higiene = Higiene(
          tarefa: rotina.key,
          hora: rotina.value,
          idpaciente: widget.paciente.idpaciente,
        );

        atualizacaoSucesso = await higiene.cadastrar();
      }

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
    } catch (error) {
      print('Erro ao salvar os dados: $error');
      showConfirmationDialog(
        context: context,
        title: 'Erro',
        message: 'Erro ao salvar os dados.',
        onConfirm: () {},
      );
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
      "Rotina de Higiene",
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
                  'Tarefa',
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
                child: task['tarefa'] == null
                    ? DropdownButtonFormField<String>(
                        value: task['tarefa'],
                        onChanged: (String? newValue) {
                          setState(() {
                            task['tarefa'] = newValue;
                          });
                        },
                        items: _taskOptions
                            .map<DropdownMenuItem<String>>((String? value) {
                          return DropdownMenuItem<String>(
                            value: value ?? '',
                            child: Text(
                              value ?? 'Selecione a tarefa',
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          hintText: 'Selecione a tarefa',
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
                        task['tarefa']!,
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
                                  if (task['tarefa'] != null) {
                                    rotinaDecubito[task['tarefa']!] =
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
        _buildButton("Adicionar Tarefa", _addTaskRow),
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
        minimumSize: const Size(250, 50),
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
      _selectedTasks.add({'tarefa': null, 'hora': null});
    });
  }
}
