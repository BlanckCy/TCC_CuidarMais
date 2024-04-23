import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/tipoCuidado/atividadefisica.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:intl/intl.dart';

class AtividadeFisicaPage extends StatefulWidget {
  final Paciente paciente;
  final int tipoCuidado;

  const AtividadeFisicaPage(
      {Key? key, required this.paciente, required this.tipoCuidado})
      : super(key: key);

  @override
  State<AtividadeFisicaPage> createState() => _AtividadeFisicaPageState();
}

class _AtividadeFisicaPageState extends State<AtividadeFisicaPage> {
  final TextEditingController _observacoesAtividadeController =
      TextEditingController();
  bool _isLoading = true;
  bool? _atividadeBoa;
  String _selectedTime = '00:00';
  List<AtividadeFisica> rotina = [];

  late AtividadeFisica atividadefisica = AtividadeFisica();

  @override
  void initState() {
    super.initState();
    _carregarInformacoes();
  }

  Future<void> _carregarInformacoes() async {
    try {
      String dataFormatada = DateFormat('yyyy-MM-dd').format(DateTime.now());
      atividadefisica.idpaciente = widget.paciente.idpaciente;
      List<AtividadeFisica> listaCuidado =
          await atividadefisica.carregar(dataFormatada);

      setState(() {
        rotina = listaCuidado;
        _isLoading = false;

        if (listaCuidado.isNotEmpty) {
          _selectedTime = listaCuidado[0].hora.toString();
          _observacoesAtividadeController.text =
              listaCuidado[0].descricao.toString();
          _atividadeBoa = listaCuidado[0].avaliacao;
        }
      });
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

      AtividadeFisica atividadefisica = AtividadeFisica(
        descricao: _observacoesAtividadeController.text,
        hora: _selectedTime,
        avaliacao: _atividadeBoa,
        idpaciente: widget.paciente.idpaciente,
      );

      if (rotina.isNotEmpty) {
        atividadefisica.idcuidado_atividadefisica =
            rotina[0].idcuidado_atividadefisica;

        atualizacaoSucesso = await atividadefisica.atualizar();
      } else {
        atualizacaoSucesso = await atividadefisica.cadastrar();
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
          : _buildActivityWidget(),
    );
  }

  Widget _buildActivityWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Rotina Atividade Física",
            style: TextStyle(
              fontSize: 20,
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
                  setState(() {
                    _atividadeBoa = true;
                  });
                },
                icon: Row(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_satisfied,
                        color: _atividadeBoa == true ? Colors.green : null),
                    const SizedBox(width: 8),
                    const Text('Bem'),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  setState(() {
                    _atividadeBoa = false;
                  });
                },
                icon: Row(
                  children: <Widget>[
                    Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: _atividadeBoa == false ? Colors.red : null,
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
                icon: const Icon(Icons.access_time),
              ),
              const SizedBox(width: 8),
              Text(
                _selectedTime,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _observacoesAtividadeController,
            maxLength: 100,
            maxLines: null,
            minLines: 2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descreva qual atividade física foi realizada..',
              counterText: '',
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (_atividadeBoa != null &&
                  _observacoesAtividadeController.text != "" &&
                  _selectedTime != "00:00") {
                _salvarInformacoes();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Por favor, preencha todos os campos.',
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
