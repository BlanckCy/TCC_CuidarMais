import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class RotinaDecubitoPage extends StatefulWidget {
  @override
  _RotinaDecubitoPageState createState() => _RotinaDecubitoPageState();
}

class _RotinaDecubitoPageState extends State<RotinaDecubitoPage> {
  List<String?> _selectedTasks = [];
final List<String> _taskOptions = [
  'Decúbito Dorsal (ou Supino)',
  'Decúbito Lateral Esquerdo',
  'Decúbito Lateral Direito',
  'Decúbito Ventral (ou Prono)',
  'Posição de Trendelenburg',
  'Posição de Fowler',
  'Posição de Sims',
  'Posição de Litotomia'
];
  List<Widget> _taskRows = [];
  List<TextEditingController> _timeControllers = [];

  @override
  void initState() {
    super.initState();
    _addTaskRow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Text(
              "Mudança de Decúbito",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildTaskHeader(), // Adicionando cabeçalho das tarefas
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: _taskRows,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addTaskRow();
                  },
                  child: Text("Adicionar Mudança"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF1C51A1),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(250, 50),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Salvar
                  },
                  child: Text("Salvar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF1C51A1),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(250, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Mudança:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Horário:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskRow(int index) {
    TextEditingController timeController = TextEditingController();
    _timeControllers.add(timeController);

    if (_selectedTasks.length <= index) {
      _selectedTasks.add(null);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedTasks[index],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTasks[index] = newValue;
                    });
                  },
                  items: _taskOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  dropdownColor: Colors.white,
                  focusColor: Colors.transparent, // Remover o destaque cinza
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    _selectTime(context, index);
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Container(
                          width: 48,
                          alignment: Alignment.center,
                          child: Icon(Icons.access_time, color: const Color(0XFF1C51A1)),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addTaskRow() {
    setState(() {
      int newIndex = _taskRows.length;
      _taskRows.add(_buildTaskRow(newIndex));
    });
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Selecione o Horário:',
      cancelText: 'Cancelar', // Altera o texto do botão de cancelar
      confirmText: 'Confirmar', // Altera o texto do botão de confirmar
      hourLabelText: 'Hora', // Altera o rótulo do campo de hora
      minuteLabelText: 'Minuto', // Altera o rótulo do campo de minuto
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _timeControllers[index].text = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    }
  }
}
