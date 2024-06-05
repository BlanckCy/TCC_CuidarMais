import 'package:cuidarmais/models/escala.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/pontoeletronico.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class RegistrarPontoPage extends StatefulWidget {
  final Paciente paciente;
  const RegistrarPontoPage({Key? key, required this.paciente})
      : super(key: key);

  @override
  State<RegistrarPontoPage> createState() => _RegistrarPontoPageState();
}

class _RegistrarPontoPageState extends State<RegistrarPontoPage> {
  List<String> registros = [];
  List<String> rotulos = [];
  bool allowAddCircle = true;
  DateTime _selectedDay = DateTime.now();

  late Escala escala = Escala();
  late Paciente paciente = widget.paciente;
  late Pontoeletronico pontoeletronico = Pontoeletronico();

  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _focusedDay = DateTime.now();

  void _setCalendarRange() {
    _firstDay = DateTime(_focusedDay.year, 5, 1);
    _lastDay = DateTime(2050, 12, 31);
  }

  @override
  void initState() {
    super.initState();
    _setCalendarRange();
    _carregarInformacoes();
  }

  Future<void> _carregarInformacoes() async {
    try {
      Escala? itemEscala;
      escala.idpaciente = paciente.idpaciente;
      escala.dia = DateFormat('yyyy-MM-dd').format(_selectedDay);
      itemEscala = await escala.carregarPorData();

      setState(() {
        registros.clear();
        rotulos.clear();
      });

      if (itemEscala != null) {
        pontoeletronico.idescala = itemEscala.idescala;
        pontoeletronico.idpaciente = paciente.idpaciente;

        pontoeletronico =
            (await pontoeletronico.carregar()) ?? Pontoeletronico();

        if (pontoeletronico.hora_entrada != null &&
            pontoeletronico.hora_entrada != '00:00') {
          setState(() {
            rotulos.add("Entrada");
            registros.add(pontoeletronico.hora_entrada!);
            allowAddCircle = false;
          });
        }
        if (pontoeletronico.hora_saida != null &&
            pontoeletronico.hora_saida != '00:00') {
          setState(() {
            rotulos.add("Saída");
            registros.add(pontoeletronico.hora_saida!);
            allowAddCircle = false;
          });
        }
      }
      setState(() {
        allowAddCircle = true;
      });
    } catch (error) {
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: 'Erro',
          message: 'Erro ao carregar informações da listaEscala',
          onConfirm: () {},
        );
      });
    }
  }

  Future<void> _salvarInformacoes() async {
    try {
      bool atualizacaoSucesso = false;
      String msg =
          'Houve um erro ao salvar os dados. Por favor, tente novamente.';

      Escala? itemEscala;
      escala.idpaciente = paciente.idpaciente;
      escala.dia = DateFormat('yyyy-MM-dd').format(_selectedDay);
      itemEscala = await escala.carregarPorData();

      if (itemEscala != null) {
        var hour = DateTime.now().hour.toString().padLeft(2, '0');
        var minute = DateTime.now().minute.toString().padLeft(2, '0');

        pontoeletronico.idescala = itemEscala.idescala;
        pontoeletronico.idpaciente = paciente.idpaciente;

        if (registros.isNotEmpty) {
          pontoeletronico =
              (await pontoeletronico.carregar()) ?? Pontoeletronico();

          if (pontoeletronico.idponto_eletronico != null) {
            pontoeletronico.hora_saida = '$hour:$minute';

            atualizacaoSucesso = await pontoeletronico.atualizar();

            rotulos.add("Saída");
            allowAddCircle = false;
          }
        } else {
          pontoeletronico.hora_entrada = '$hour:$minute';
          pontoeletronico.hora_saida = '00:00';
          rotulos.add("Entrada");

          atualizacaoSucesso = await pontoeletronico.cadastrar();
        }
        if (atualizacaoSucesso) {
          setState(() {
            registros.add('$hour:$minute');
          });
        } else {
          setState(() {
            rotulos = [];
          });
        }
      } else {
        atualizacaoSucesso = false;
        msg =
            'Necessário cadastrar a data na escala antes de registrar o ponto';
      }

      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
          message: atualizacaoSucesso
              ? 'As informações foram salvas com sucesso!'
              : msg,
          onConfirm: () {},
        );
      });
    } catch (error) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TableCalendar(
            locale: 'pt_Br',
            firstDay: _firstDay,
            lastDay: _lastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(day, _selectedDay);
            },
            calendarFormat: CalendarFormat.week,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showConfirmationDialog();
            },
            availableCalendarFormats: const {CalendarFormat.week: 'Semana'},
            headerStyle: const HeaderStyle(
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 49, 89, 149),
              ),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 49, 89, 149),
                  width: 2,
                ),
              ),
              todayTextStyle: const TextStyle(color: Colors.black),
              defaultTextStyle: const TextStyle(color: Colors.black),
            ),
          ),
          // if (registros.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(
            'Registros de ${DateFormat('dd/MM/yyyy').format(_selectedDay)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          // ],
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < registros.length; i++)
                _buildCircle(
                  registros[i],
                  rotulos.length > i ? rotulos[i] : null,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    String diaSelecionadoFormatado =
        DateFormat('dd/MM/yyyy').format(_selectedDay);
    String diaAtualFormatado = DateFormat('dd/MM/yyyy').format(DateTime.now());

    if ((diaSelecionadoFormatado != diaAtualFormatado) || !allowAddCircle) {
      _carregarInformacoes();
    } else {
      if (allowAddCircle) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:
                  Text('Dia ${DateFormat('dd/MM/yyyy').format(_selectedDay)}'),
              content: Text(
                  'Deseja registrar o ponto de ${registros.isNotEmpty ? 'Saída' : 'Entrada'}?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    _salvarInformacoes();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      } else {
        return;
      }
    }
  }

  Widget _buildCircle(String hora, String? rotulo) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 49, 89, 149),
          ),
          child: Center(
            child: Text(
              hora,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        if (rotulo != null)
          Text(
            rotulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
