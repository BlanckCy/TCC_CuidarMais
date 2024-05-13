import 'package:cuidarmais/models/rotina.dart';
import 'package:cuidarmais/models/tipoCuidado/sinaisvitais.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class SinaisVitaisPage extends StatefulWidget {
  final int tipoCuidado;

  const SinaisVitaisPage({
    Key? key,
    required this.tipoCuidado,
  }) : super(key: key);

  @override
  State<SinaisVitaisPage> createState() => _SinaisVitaisPageState();
}

class _SinaisVitaisPageState extends State<SinaisVitaisPage> {
  String? _selectedSistolica;
  String? _selectedDiastolica;
  String? _selectedTemperatura;
  String? _selectedRespiracao;
  String? _selectedFrequenciaCardiaca;
  final TextEditingController _observacoesController = TextEditingController();

  bool _isLoading = true;

  List<SinaisVitais> listaSinaisVitais = [];
  List<Rotina> listaRotina = [];

  late SinaisVitais sinaisvitais = SinaisVitais();
  late Rotina rotina = Rotina();
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
        cuidado: 'Sinais Vitais',
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
      sinaisvitais.idpaciente = paciente.idpaciente;

      listaRotina = await _validarRotina();
      sinaisvitais.idrotina = listaRotina[0].idrotina;

      List<SinaisVitais> listaCuidado = await sinaisvitais.carregar();

      setState(() {
        listaSinaisVitais = listaCuidado;
        _isLoading = false;

        if (listaCuidado.isNotEmpty) {
          _selectedSistolica = listaCuidado[0].pressao_sistolica.toString();
          _selectedDiastolica = listaCuidado[0].pressao_diastolica.toString();
          _selectedTemperatura = listaCuidado[0].temperatura.toString();
          _selectedRespiracao =
              listaCuidado[0].frequencia_respiratoria.toString();
          _selectedFrequenciaCardiaca =
              listaCuidado[0].frequencia_cardiaca.toString();
          _observacoesController.text = listaCuidado[0].descricao ?? '';
        }
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Future.microtask(() {
        showConfirmationDialog(
          context: context,
          title: 'Erro',
          message: 'Erro ao carregar informações da listaSinaisVitais',
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

      SinaisVitais sinaisvitais = SinaisVitais(
        pressao_diastolica: _selectedDiastolica,
        pressao_sistolica: _selectedSistolica,
        temperatura: _selectedTemperatura,
        frequencia_cardiaca: _selectedFrequenciaCardiaca,
        frequencia_respiratoria: _selectedRespiracao,
        descricao: _observacoesController.text,
        idpaciente: paciente.idpaciente,
        idrotina: listaRotina[0].idrotina,
      );

      if (listaSinaisVitais.isNotEmpty) {
        sinaisvitais.idcuidado_sinaisvitais =
            listaSinaisVitais[0].idcuidado_sinaisvitais;
        atualizacaoSucesso = await sinaisvitais.atualizar();
      } else {
        atualizacaoSucesso = await sinaisvitais.cadastrar();
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
      Future.microtask(() {
        print('Erro ao salvar os dados: $error');
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
          : _buildSinaisVitais(),
    );
  }

  Widget _buildDropdownButton(
      {required String title,
      required String labelText,
      required String? value,
      required Function(String?) onChanged,
      required List<DropdownMenuItem<String>> items,
      required String? tipo}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text('$labelText:'),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: value ?? "",
              onChanged: onChanged,
              items: items,
              menuMaxHeight: 200,
            ),
            Text(tipo ?? ''),
          ],
        ),
      ],
    );
  }

  Widget _buildObservacoesTextField() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: _observacoesController,
        maxLength: 100,
        maxLines: null,
        decoration: const InputDecoration(
          hintText: 'Observações',
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }

  Widget _buildSinaisVitais() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Rotina de Sinais Vitais",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Sempre consulte um profissional de saúde para obter os valores normais específicos para cada caso.",
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildDropdownButton(
                      title: "Pressão Arterial",
                      labelText: 'Pressão Sistólica',
                      value: _selectedSistolica,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSistolica = newValue;
                          sinaisvitais.pressao_sistolica = newValue;
                        });
                      },
                      items: [
                        const DropdownMenuItem<String>(
                          value: "",
                          child: Text('Selecione'),
                        ),
                        for (int i = 0; i < 13; i++)
                          DropdownMenuItem<String>(
                            value: '${90 + i * 5}',
                            child: Text('${90 + i * 5}'),
                          ),
                      ],
                      tipo: ''),
                  const SizedBox(height: 12),
                  _buildDropdownButton(
                      title: "",
                      labelText: 'Pressão Diastólica',
                      value: _selectedDiastolica,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDiastolica = newValue;
                          sinaisvitais.pressao_diastolica = newValue;
                        });
                      },
                      items: [
                        const DropdownMenuItem<String>(
                          value: "",
                          child: Text('Selecione'),
                        ),
                        for (int i = 0; i < 13; i++)
                          DropdownMenuItem<String>(
                            value: '${50 + i * 5}',
                            child: Text('${50 + i * 5}'),
                          ),
                      ],
                      tipo: ''),
                  const SizedBox(height: 4),
                  const Text(
                    'Faixa de referência para adultos: 120/80 mmHg',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildDropdownButton(
                      title: "Temperatura",
                      labelText: 'Selecione o valor',
                      value: _selectedTemperatura,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedTemperatura = newValue;
                          sinaisvitais.temperatura = newValue;
                        });
                      },
                      items: [
                        const DropdownMenuItem<String>(
                          value: "",
                          child: Text('Selecione'),
                        ),
                        for (int i = 0; i < 50; i++)
                          DropdownMenuItem<String>(
                            value: (351 + i).toString(),
                            child: Text(
                              (35.1 + i * 0.1).toStringAsFixed(1),
                            ),
                          ),
                      ],
                      tipo: '°C'),
                  const SizedBox(height: 4),
                  const Text(
                    'Faixa de referência: Entre 35,4°C e 37,2°C',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildDropdownButton(
                    title: 'Frequência Respiratória',
                    labelText: 'Selecione o valor',
                    value: _selectedRespiracao,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRespiracao = newValue;
                        sinaisvitais.frequencia_respiratoria = newValue;
                      });
                    },
                    items: [
                      const DropdownMenuItem<String>(
                        value: "",
                        child: Text('Selecione'),
                      ),
                      for (int i = 0; i < 25; i++)
                        DropdownMenuItem<String>(
                          value: (8 + i).toString(),
                          child: Text((8 + i).toString()),
                        ),
                    ],
                    tipo: 'IRPM',
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Faixa de referência: Adultos: 12 a 20 (IRPM);\nAdultos +40 anos: 16 a 25 (IRPM)',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildDropdownButton(
                    title: 'Frequência Cardíaca',
                    labelText: 'Selecione o valor',
                    value: _selectedFrequenciaCardiaca,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedFrequenciaCardiaca = newValue;
                        sinaisvitais.frequencia_cardiaca = newValue;
                      });
                    },
                    items: [
                      const DropdownMenuItem<String>(
                        value: "",
                        child: Text('Selecione'),
                      ),
                      for (int i = 0; i < 100; i++)
                        DropdownMenuItem<String>(
                          value: (30 + i).toString(),
                          child: Text((30 + i).toString()),
                        ),
                    ],
                    tipo: 'BPM',
                  ),
                  const Text(
                    'Faixa de referência para adultos: 60 a 100 batimentos por minuto (BPM)',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            _buildObservacoesTextField(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _salvarInformacoes();
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
    );
  }
}
