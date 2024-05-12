import 'package:cuidarmais/models/escala.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class EscalaTrabalhoPage extends StatefulWidget {
  const EscalaTrabalhoPage({Key? key}) : super(key: key);

  @override
  State<EscalaTrabalhoPage> createState() => _EscalaTrabalhoPageState();
}

class _EscalaTrabalhoPageState extends State<EscalaTrabalhoPage> {
  final TextEditingController _horaInicialController = TextEditingController();
  final TextEditingController _horaFinalController = TextEditingController();

  late DateTime diaSelecionado;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _focusedDay = DateTime.now();

  Map<DateTime, List<Event>> events = {};

  List<Escala> listaEscala = [];
  late Paciente paciente = Paciente();
  late Escala escala = Escala();

  bool _isLoading = true;

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
        _carregarInformacoes();
      });
    } else {}
  }

  Future<void> _carregarInformacoes() async {
    try {
      escala.idpaciente = paciente.idpaciente;

      listaEscala = await escala.carregar();

      for (var escala in listaEscala) {
        _addEvent(
          DateTime.parse(escala.dia!),
          escala.hora_inicio!,
          escala.hora_final!,
        );
      }

      setState(() {
        _isLoading = false;
        _setCalendarRange();
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: 'Erro',
          message: 'Erro ao carregar informações da listaEscala',
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      });
    }
  }

  Future<void> _cadastrar() async {
    escala.idpaciente = paciente.idpaciente;
    escala.dia = DateFormat('yyyy-MM-dd').format(diaSelecionado);
    escala.hora_inicio = _horaInicialController.text;
    escala.hora_final = _horaFinalController.text;

    DateTime diaFormatado =
        DateTime(diaSelecionado.year, diaSelecionado.month, diaSelecionado.day);

    bool atualizacaoSucesso = await escala.cadastrar();
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
            setState(() {
              _addEvent(diaFormatado, _horaInicialController.text,
                  _horaFinalController.text);
            });
          }
        },
      );
    });
  }

  void _addEvent(DateTime selectedDay, String horaInicio, String horaFinal) {
    final horainicio = _parseTimeOfDay(horaInicio);
    final horafinal = _parseTimeOfDay(horaFinal);

    events.putIfAbsent(selectedDay, () => []);
    events[selectedDay]!.add(Event(horainicio, horafinal));
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  void _setCalendarRange() {
    _firstDay = DateTime.utc(_focusedDay.year, _focusedDay.month, 1);
    _lastDay = DateTime.utc(2050, 12, 31);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildEscalaWidget(),
    );
  }

  Widget _buildEscalaWidget() {
    Map<DateTime, List<Event>> filteredEvents = Map.fromEntries(
      events.entries.where((entry) =>
          entry.key.month == _focusedDay.month &&
          entry.key.year == _focusedDay.year),
    );
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Selecione a data desejada, insira o horário de ínicio e fim do plantão.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          TableCalendar(
            locale: 'pt_Br',
            firstDay: _firstDay,
            lastDay: _lastDay,
            focusedDay: _focusedDay,
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              if (events[selectedDay] == null || events[selectedDay]!.isEmpty) {
                _showAddEscalaDialog(selectedDay);
              }
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
          ),
          const SizedBox(height: 20),
          const Text(
            'Escalas:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0XFF1C51A1),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _buildescalasList(filteredEvents),
            ),
          ),
        ],
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    return events[normalizedDay] ?? [];
  }

  Widget _buildescalasList(Map<DateTime, List<Event>> events) {
    // Ordenar as chaves do mapa
    List<DateTime> sortedDays = events.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedDays.map((day) {
        final formattedDay = DateFormat('dd/MM/yyyy').format(day);
        List<Event> sortedEvents = events[day]!;
        sortedEvents.sort((a, b) {
          return _timeOfDayToDateTime(a.horaInicial)
              .compareTo(_timeOfDayToDateTime(b.horaInicial));
        });
        List<Widget> dayEvents = sortedEvents.map((event) {
          final inicio = _formatTime(event.horaInicial);
          final fim = _formatTime(event.horaFinal);
          return Text(
            '- Dia $formattedDay: Entrada $inicio e Saída $fim',
            style: const TextStyle(fontSize: 14),
          );
        }).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dayEvents,
        );
      }).toList(),
    );
  }

  DateTime _timeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  String _formatTime(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _showAddEscalaDialog(DateTime selectedDay) async {
    diaSelecionado = selectedDay;
    _horaInicialController.text = '00:00';
    _horaFinalController.text = '00:00';

    DateTime diaFormat =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    if (events.containsKey(diaFormat)) {
      return;
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registrar Escala'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTimeField(_horaInicialController, 'Início do plantão'),
              _buildTimeField(_horaFinalController, 'Fim do plantão'),
            ],
          ),
          actions: <Widget>[
            _buildActionButton('Cancelar', () {
              Navigator.of(context).pop();
            }),
            _buildActionButton('Adicionar', () {
              _cadastrar();
            }),
          ],
        );
      },
    );
  }

  Widget _buildTimeField(TextEditingController controller, String hintText) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      onTap: () async {
        final pickedTime = await _selectTime(context);
        if (pickedTime != null) {
          setState(() {
            controller.text = pickedTime.format(context);
          });
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: const Icon(Icons.access_time),
      ),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Widget _buildActionButton(String text, void Function()? onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class Event {
  final TimeOfDay horaInicial;
  final TimeOfDay horaFinal;

  Event(this.horaInicial, this.horaFinal);
}
