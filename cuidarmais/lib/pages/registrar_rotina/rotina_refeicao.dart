import 'package:cuidarmais/models/cuidado.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:intl/intl.dart';

class RefeicaoPage extends StatefulWidget {
  final Paciente paciente;
  final int tipoCuidado;

  const RefeicaoPage(
      {Key? key, required this.paciente, required this.tipoCuidado})
      : super(key: key);

  @override
  State<RefeicaoPage> createState() => _RefeicaoPageState();
}

class _RefeicaoPageState extends State<RefeicaoPage> {
  final TextEditingController _observacoesCafeManhaController =
      TextEditingController();
  final TextEditingController _observacoesAlmocoController =
      TextEditingController();
  final TextEditingController _observacoesJantarController =
      TextEditingController();

  bool _isLoading = true;

  bool? _cafeManhaBoa;
  bool? _almocoBoa;
  bool? _jantarBoa;

  String _cafeManhaHorarioSelecionado = '00:00';
  String _almocoHorarioSelecionado = '00:00';
  String _jantarHorarioSelecionado = '00:00';

  List<Cuidado> rotina = [];

  @override
  void initState() {
    super.initState();
    String dataFormatada = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _carregarRotina(
      tipo_cuidado: widget.tipoCuidado,
      data: dataFormatada,
    );
    Cuidado cuidado = Cuidado();
  }

  Future<void> _carregarRotina({
    required int tipo_cuidado,
    required String data,
  }) async {
    try {
      var listaCuidados = await Cuidado().carregarRotina(
        tipo_cuidado,
        data,
      );

      print(listaCuidados);

      if (listaCuidados.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      setState(() {
        rotina = listaCuidados;
        for (var cuidado in rotina) {
          if (cuidado.cuidado == 'Café da Manhã') {
            _observacoesCafeManhaController.text = cuidado.descricao ?? '';
            _cafeManhaBoa = cuidado.avaliacao;
            _cafeManhaHorarioSelecionado = cuidado.horario_realizado ?? '';
          }
          if (cuidado.cuidado == 'Almoço') {
            _observacoesAlmocoController.text = cuidado.descricao ?? '';
            _almocoBoa = cuidado.avaliacao;
            _almocoHorarioSelecionado = cuidado.horario_realizado ?? '';
          }
          if (cuidado.cuidado == 'Jantar') {
            _observacoesJantarController.text = cuidado.descricao ?? '';
            _jantarBoa = cuidado.avaliacao;
            _jantarHorarioSelecionado = cuidado.horario_realizado ?? '';
          }
        }

        _isLoading = false;
      });
    } catch (error) {
      print('Erro ao carregar rotina: $error');
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

  bool mensagemExibida = false;

  Future<void> _cadastrarRefeicoes() async {
    // Cadastrar café da manhã
    await _cadastrarRefeicao(
      descricao: _observacoesCafeManhaController.text,
      avaliacao: _cafeManhaBoa!,
      horario_realizado: _cafeManhaHorarioSelecionado,
      nomeCuidado: "Café da Manhã",
    );

    // Cadastrar almoço
    await _cadastrarRefeicao(
      descricao: _observacoesAlmocoController.text,
      avaliacao: _almocoBoa!,
      horario_realizado: _almocoHorarioSelecionado,
      nomeCuidado: "Almoço",
    );

    // Cadastrar jantar
    await _cadastrarRefeicao(
      descricao: _observacoesJantarController.text,
      avaliacao: _jantarBoa!,
      horario_realizado: _jantarHorarioSelecionado,
      nomeCuidado: 'Jantar',
    );

    // Exibir a mensagem apenas uma vez após todos os cadastros
    if (!mensagemExibida) {
      mensagemExibida = true;
      _exibirMensagem();
    }
  }

  void _exibirMensagem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('OK'),
          content: Text('Os dados foram salvos com sucesso!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cadastrarRefeicao(
      {required String descricao,
      required bool avaliacao,
      required String horario_realizado,
      required String nomeCuidado}) async {
    Cuidado cuidado = Cuidado(
      data_hora: DateTime.now().toString(),
      avaliacao: avaliacao,
      tipo_cuidado: widget.tipoCuidado,
      descricao: descricao,
      horario_realizado: horario_realizado,
      cuidado: nomeCuidado,
      idpaciente: widget.paciente.idpaciente,
    );

    bool salvarSucesso = await cuidado.cadastrar();
  }

  Widget _buildMealWidget(
    String mealName,
    TextEditingController controller,
    bool? isBoa,
    Function(bool?) setStatus,
    Function(TimeOfDay?) setHorario,
    String selectedTime,
  ) {
    return Column(
      children: <Widget>[
        Text(
          mealName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setStatus(true);
              },
              icon: Row(
                children: <Widget>[
                  Icon(Icons.sentiment_very_satisfied,
                      color: isBoa == true ? Colors.green : null),
                  const SizedBox(width: 8),
                  const Text('Bem'),
                ],
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                setStatus(false);
              },
              icon: Row(
                children: <Widget>[
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: isBoa == false ? Colors.red : null,
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
                setHorario(selectedTime);
              },
              icon: const Icon(Icons.access_time),
            ),
            const SizedBox(width: 8),
            Text(
              selectedTime,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: controller,
            maxLength: 100,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descreva como foi a alimentação..',
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }

  /* Future<void> _atualizarDados() async {
    cuidado.av = nomeController.text;
    contatoemergencia.parentesco = parentescoController.text;
    contatoemergencia.telefone = telefoneController.text;

    bool atualizacaoSucesso = await contatoemergencia.atualizarDados();

    showConfirmationDialog(
      context: context,
      title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
      message: atualizacaoSucesso
          ? 'Os dados foram atualizados com sucesso!'
          : 'Houve um erro ao atualizar os dados. Por favor, tente novamente.',
      onConfirm: () {
        // Navigator.of(context).pop();
      },
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildRotinaRefeicao(),
    );
  }

  Widget _buildRotinaRefeicao() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Como o paciente se alimentou hoje?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Selecione a carinha que melhor representa como o paciente se alimentou e o horário correspondente.",
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildMealWidget(
              "Café da manhã",
              _observacoesCafeManhaController,
              _cafeManhaBoa,
              (bool? status) {
                if (status != null) {
                  setState(
                    () {
                      _cafeManhaBoa = status;
                    },
                  );
                }
              },
              (TimeOfDay? selectedTime) {
                if (selectedTime != null) {
                  setState(() {
                    _cafeManhaHorarioSelecionado = _formatTime(selectedTime);
                  });
                }
              },
              _cafeManhaHorarioSelecionado,
            ),
            const SizedBox(height: 20),
            _buildMealWidget(
              "Almoço",
              _observacoesAlmocoController,
              _almocoBoa,
              (bool? status) {
                if (status != null) {
                  setState(() {
                    _almocoBoa = status;
                  });
                }
              },
              (TimeOfDay? selectedTime) {
                if (selectedTime != null) {
                  setState(() {
                    _almocoHorarioSelecionado = _formatTime(selectedTime);
                  });
                }
              },
              _almocoHorarioSelecionado,
            ),
            const SizedBox(height: 20),
            _buildMealWidget(
              "Jantar",
              _observacoesJantarController,
              _jantarBoa,
              (bool? status) {
                if (status != null) {
                  setState(() {
                    _jantarBoa = status;
                  });
                }
              },
              (TimeOfDay? selectedTime) {
                if (selectedTime != null) {
                  setState(() {
                    _jantarHorarioSelecionado = _formatTime(selectedTime);
                  });
                }
              },
              _jantarHorarioSelecionado,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_cafeManhaBoa != null ||
                    _almocoBoa != null ||
                    _jantarBoa != null) {
                  if (rotina.isEmpty) {
                    _cadastrarRefeicoes();
                  } else {}
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Por favor, selecione se o paciente se alimentou bem ou mal e o hórario em pelo menos uma das refeições.'),
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
