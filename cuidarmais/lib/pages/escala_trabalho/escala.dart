import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final DateTime horaInicial;
  final DateTime horaFinal;

  Event(this.horaInicial, this.horaFinal);
}

class EscalaTrabalhoPage extends StatefulWidget {
  @override
  _EscalaTrabalhoPageState createState() => _EscalaTrabalhoPageState();
}

class _EscalaTrabalhoPageState extends State<EscalaTrabalhoPage> {
  Map<DateTime, List<Event>> events = {};

 Future<String?> _selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime != null) {
    return '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
  }
  return null;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Selecione a data desejada, insira o horário de ínicio e fim do plantão.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              TableCalendar(
                firstDay: DateTime.utc(2024, 5, 1),
                lastDay: DateTime.utc(2024, 5, 31),
                focusedDay: DateTime.now(),
                eventLoader: (day) => events[day] ?? [],
                onDaySelected: (selectedDay, focusedDay) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController _horaInicialController =
                          TextEditingController();
                      TextEditingController _horaFinalController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Registrar Escala'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              readOnly: true,
                              controller: _horaInicialController,
                              decoration: InputDecoration(
                                hintText: 'Início do plantão',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.access_time),
                                  onPressed: () async {
                                    final pickedTime =
                                        await _selectTime(context);
                                    if (pickedTime != null) {
                                      setState(() {
                                        _horaInicialController.text = pickedTime;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _horaFinalController,
                              decoration: InputDecoration(
                                hintText: 'Fim do plantão',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.access_time),
                                  onPressed: () async {
                                    final pickedTime =
                                        await _selectTime(context);
                                    if (pickedTime != null) {
                                      setState(() {
                                        _horaFinalController.text = pickedTime;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                final event = Event(
                                  DateTime.parse(
                                      '2024-05-06 ${_horaInicialController.text}'),
                                  DateTime.parse(
                                      '2024-05-06 ${_horaFinalController.text}'),
                                );
                                if (events[selectedDay] != null) {
                                  events[selectedDay]!.add(event);
                                } else {
                                  events[selectedDay] = [event];
                                }
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text('Adicionar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Text('Escalas:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF1C51A1),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: events.keys.map((day) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: events[day]!.map((event) {
                      return Text(
                          '- Dia ${_formattedDate(day)}: Entrada ${event.horaInicial.hour}h${event.horaInicial.minute} e Saída ${event.horaFinal.hour}h${event.horaFinal.minute}',
                          style: TextStyle(fontSize: 16));
                    }).toList(),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formattedDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
