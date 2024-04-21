import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class SinaisVitaisPage extends StatefulWidget {
  @override
  _SinaisVitaisPageState createState() => _SinaisVitaisPageState();
}

class _SinaisVitaisPageState extends State<SinaisVitaisPage> {
  String? _selectedSistolica;
  String? _selectedDiastolica;
  String? _selectedTemperatura;
  String? _selectedRespiracao;
  String? _selectedFrequenciaCardiaca;

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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Como está o paciente hoje?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Pressão Arterial',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Pressão Sistólica:'),
                        SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedSistolica,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSistolica = newValue;
                            });
                          },
                          items: List.generate(
                              13,
                              (index) => DropdownMenuItem<String>(
                                    value: '${90 + index * 5}',
                                    child: Text('${90 + index * 5}'),
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Pressão Diastólica:'),
                        SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedDiastolica,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedDiastolica = newValue;
                            });
                          },
                          items: List.generate(
                              13,
                              (index) => DropdownMenuItem<String>(
                                    value: '${50 + index * 5}',
                                    child: Text('${50 + index * 5}'),
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Valores máximos aceitáveis:\nMulher 134/84 mmHg \nHomem 135/88 mmHg',
                      style: TextStyle(
                        color: Colors.blue, // Cor do texto
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Temperatura',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    DropdownButton<String>(
                      value: _selectedTemperatura,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTemperatura = newValue;
                        });
                      },
                      items: List.generate(
                          50,
                          (index) => DropdownMenuItem<String>(
                                value:
                                    '${(35 + index * 0.1).toStringAsFixed(1)} °C',
                                child: Text(
                                    '${(35 + index * 0.1).toStringAsFixed(1)} °C'),
                              )),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Valores normais: Entre 36,1ºC e 37,2ºC',
                      style: TextStyle(
                        color: Colors.blue, // Cor do texto
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Frequência Respiratória',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    DropdownButton<String>(
                      value: _selectedRespiracao,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRespiracao = newValue;
                        });
                      },
                      items: List.generate(
                          25,
                          (index) => DropdownMenuItem<String>(
                                value: '${8 + index} IRPM',
                                child: Text('${8 + index} IRPM'),
                              )),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Valores normais: \nAdultos – 12 a 20 incursões respiratórias por minuto (IRPM);',
                      style: TextStyle(
                        color: Colors.blue, // Cor do texto
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Frequência Cardíaca',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    DropdownButton<String>(
                      value: _selectedFrequenciaCardiaca,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFrequenciaCardiaca = newValue;
                        });
                      },
                      items: List.generate(
                          100,
                          (index) => DropdownMenuItem<String>(
                                value: '${30 + index} BPM',
                                child: Text('${30 + index} BPM'),
                              )),
                    ),
                    Text(
                      'Valores normais: \nIdosos: 40 a 100 batimentos por minuto (BPM)',
                      style: TextStyle(
                        color: Colors.blue, // Cor do texto
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  maxLines: null, // Permite várias linhas
                  decoration: InputDecoration(
                    hintText: 'Observações',
                    border: InputBorder.none, // Remove a borda do TextField
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    onPressed: () {
                      // Adicione aqui a lógica para registrar os sinais
                    },
                    child: Text(
                      'Registrar Sinais Vitais',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100.0, 60.0),
                      backgroundColor: const Color(0XFF1C51A1),
                      foregroundColor: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
