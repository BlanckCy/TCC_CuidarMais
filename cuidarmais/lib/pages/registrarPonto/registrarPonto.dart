import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class RegistrarPontoPage extends StatefulWidget {
  @override
  _RegistrarPontoPageState createState() => _RegistrarPontoPageState();
}

class _RegistrarPontoPageState extends State<RegistrarPontoPage> {
  List<String> registros = [];
  List<String> rotulos = []; // Lista de rótulos para os círculos
  bool allowAddCircle = true;
  DateTime selectedDay = DateTime.now(); // Inicializando com a data atual
  bool isEntryAdded = false; // Variável para controlar se o primeiro círculo foi adicionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(day, selectedDay);
              },
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                  color: Color(0XFF1C51A1),
                ),
                formatButtonVisible: false, // Ocultar botão de formato
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0XFF1C51A1),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                weekendTextStyle: TextStyle(
                  color: Color(0XFF1C51A1),
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5), // Cor do destaque selecionado
                  shape: BoxShape.circle,
                ),
              ),
              calendarFormat: CalendarFormat.week, // Mostrar apenas uma semana
              onPageChanged: (focusedDay) {
                // Lidar com a mudança de página
              },
              onDaySelected: (selectedDate, focusedDate) {
                setState(() {
                  selectedDay = selectedDate; // Atualizando o dia selecionado
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Registros de ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < registros.length; i++)
                  _buildCircle(registros[i], rotulos.length > i ? rotulos[i] : null),
              ],
            ),
            SizedBox(height: 40), // Adiciona espaço entre os círculos e o botão
            ElevatedButton.icon(
              onPressed: allowAddCircle
                  ? () {
                      setState(() {
                        var hour = DateTime.now().hour.toString().padLeft(2, '0');
                        var minute = DateTime.now().minute.toString().padLeft(2, '0');
                        registros.add('$hour:$minute');
                        if (registros.length >= 2) {
                          allowAddCircle = false;
                          rotulos.add("Saída"); // Adiciona o rótulo "Saída" para o segundo círculo
                        } else {
                          rotulos.add("Entrada"); // Adiciona o rótulo "Entrada" para o primeiro círculo
                        }
                        isEntryAdded = true; // Indica que pelo menos um círculo foi adicionado
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF1C51A1),
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50),
              ),
              icon: Icon(Icons.access_time),
              label: Text("Registrar Ponto"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(String hora, String? rotulo) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0XFF1C51A1),
          ),
          child: Center(
            child: Text(
              hora,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (rotulo != null) // Exibe o rótulo se não for nulo
          Text(
            rotulo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
