import 'package:cuidarmais/models/tipoCuidado/medicacaolista.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:intl/intl.dart';

class MedicationRegistrationPage extends StatefulWidget {
  const MedicationRegistrationPage({Key? key}) : super(key: key);

  @override
  State<MedicationRegistrationPage> createState() =>
      _MedicationRegistrationPageState();
}

class _MedicationRegistrationPageState
    extends State<MedicationRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedTime = "00:00";
  String _selectTipoDosagem = "";

  late MedicacaoLista medicacaolista = MedicacaoLista();
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
    } else {}
  }

  Future<void> _cadastrar() async {
    medicacaolista.idpaciente = paciente.idpaciente;
    bool atualizacaoSucesso = await medicacaolista.cadastrar();
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
              '/rotinaMedicacao',
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Cadastro de Medicamento',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.medical_services_outlined,
                      color: Color(0XFF1C51A1),
                    ),
                    labelText: 'Nome do Medicamento',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Digite o nome do medicamento',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do medicamento';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    medicacaolista.medicamento = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.medication_outlined,
                      color: Color(0XFF1C51A1),
                    ),
                    labelText: 'Dosagem',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Digite a dosagem',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a dosagem do medicamento';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    medicacaolista.dosagem = value!;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectTipoDosagem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectTipoDosagem = newValue!;
                    });
                  },
                  items: <String?>[
                    null,
                    'Comprimido',
                    'ml',
                    'Gotas',
                    'Colher',
                    'Injeção',
                    'Sachê',
                    'Adesivo'
                  ].map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value ?? '',
                      child: Text(
                        value ?? 'Selecione o tipo do medicamento',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.medication_liquid,
                      color: Color(0XFF1C51A1),
                    ),
                    hintText: 'Selecione o tipo do medicamento',
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
                  menuMaxHeight: 200,
                  isExpanded: true,
                  onSaved: (value) {
                    medicacaolista.tipo = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione o tipo do medicamento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (selectedTime != null) {
                            setState(() {
                              _selectedTime = _formatTime(selectedTime);
                              medicacaolista.hora = _selectedTime;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  setState(() {
                                    _selectedTime = _formatTime(selectedTime);
                                    medicacaolista.hora =
                                        _formatTime(selectedTime);
                                  });
                                }
                              },
                              color: const Color(0XFF1C51A1),
                              icon: const Icon(Icons.access_time),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedTime,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _cadastrar();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0XFF1C51A1),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay? time) {
    if (time != null) {
      // Convertendo TimeOfDay para DateTime
      final now = DateTime.now();
      final DateTime selectedTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);

      // Formatando o DateTime
      final formattedTime = DateFormat.Hm().format(selectedTime);

      return formattedTime;
    } else {
      // Se nenhum horário for selecionado, retornar uma string vazia
      return '';
    }
  }
}
