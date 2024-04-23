
import 'package:cuidarmais/models/cuidado.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:intl/intl.dart';

class AtividadePage extends StatefulWidget {

  const AtividadePage({Key? key}) : super(key: key);

  @override
  State<AtividadePage> createState() => _AtividadePageState();
}

class _AtividadePageState extends State<AtividadePage> {
  final TextEditingController _observacoesAtividadeController = TextEditingController();
  bool _isLoading = false;
  bool? _atividadeBoa;
  bool? _isBoa;
  String _selectedTime = '00:00';
  List<Cuidado> rotina = [];
  

  @override
  void initState() {
    super.initState();
    String dataFormatada = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // _carregarRotina(tipoCuidado: widget.tipoCuidado, data: dataFormatada);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildActivityWidget(),
    );
  }

  Widget _buildActivityWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "O paciente realizou atividade física hoje?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Selecione a carinha que melhor representa como o paciente se exercitou e o horário correspondente.",
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
               
               Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                _isBoa = true;
              },
              icon: Row(
                children: <Widget>[
                  Icon(Icons.sentiment_very_satisfied,
                      color: _isBoa == true ? Colors.green : null),
                  const SizedBox(width: 8),
                  const Text('Bem'),
                ],
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                
              },
              icon: Row(
                children: <Widget>[
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: _isBoa == false ? Colors.red : null,
                  ),
                  const SizedBox(width: 8),
                  const Text('Mal'),
                ],
              ),
            ),
            const SizedBox(width: 10),
                                        IconButton(
                              onPressed: () async {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  setState(() {
                                    _selectedTime = _formatTime(selectedTime);
                                    
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
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            maxLength: 100,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descreva qual atividade física foi realizada..',
              counterText: '',
            ),
          ),
        ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_atividadeBoa != null) {                  
                } else {
                  ScaffoldMessenger.of(context

                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Por favor, selecione se o paciente realizou atividade física hoje.',
                      ),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0XFF1C51A1),
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50),
              ),
              child: const Text("Salvar"),
            ),
          ],
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
