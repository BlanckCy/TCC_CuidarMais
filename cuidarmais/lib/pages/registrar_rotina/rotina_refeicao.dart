import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/rotina.dart';
import 'package:cuidarmais/models/tipoCuidado/refeicao.dart';
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

  List<Refeicao> listaRefeicao = [];
  List<Rotina> listaRotina = [];

  late Refeicao refeicao = Refeicao();
  late Rotina rotina = Rotina();

  @override
  void initState() {
    super.initState();
    _carregarInformacoes();
  }

  Future<List<Rotina>> _validarRotina() async {
    try {
      Rotina rotina = Rotina(
        idpaciente: widget.paciente.idpaciente,
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
      showConfirmationDialog(
        context: context,
        title: 'Erro',
        message: 'Erro ao carregar informações da rotina',
        onConfirm: () {
          Navigator.of(context).pop();
        },
      );
      return [];
    }
  }

  Future<void> _carregarInformacoes() async {
    try {
      refeicao.idpaciente = widget.paciente.idpaciente;

      listaRotina = await _validarRotina();
      refeicao.idrotina = listaRotina[0].idrotina;

      List<Refeicao> listaCuidado = await refeicao.carregar();

      setState(() {
        listaRefeicao = listaCuidado;
        _isLoading = false;

        if (listaCuidado.isNotEmpty) {
          _observacoesCafeManhaController.text =
              listaRefeicao[0].descricao_cafe ?? '';
          _cafeManhaBoa = listaRefeicao[0].avaliacao_cafe;
          _cafeManhaHorarioSelecionado = listaRefeicao[0].hora_cafe ?? '00:00';

          _observacoesAlmocoController.text =
              listaRefeicao[0].descricao_almoco ?? '';
          _almocoBoa = listaRefeicao[0].avaliacao_almoco;
          _almocoHorarioSelecionado = listaRefeicao[0].hora_almoco ?? '00:00';

          _observacoesJantarController.text =
              listaRefeicao[0].descricao_jantar ?? '';
          _jantarBoa = listaRefeicao[0].avaliacao_jantar;
          _jantarHorarioSelecionado = listaRefeicao[0].hora_jantar ?? '00:00';
        }
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      showConfirmationDialog(
        context: context,
        title: 'Erro',
        message: 'Erro ao carregar informações da listaRefeicao',
        onConfirm: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  bool mensagemExibida = false;
  bool sucesso = false;

  Future<void> _salvarInformacoes() async {
    bool atualizacaoSucesso = false;

    Refeicao refeicao = Refeicao(
      avaliacao_cafe: _cafeManhaBoa,
      hora_cafe: _cafeManhaHorarioSelecionado,
      descricao_cafe: _observacoesCafeManhaController.text,
      avaliacao_almoco: _almocoBoa,
      hora_almoco: _almocoHorarioSelecionado,
      descricao_almoco: _observacoesAlmocoController.text,
      avaliacao_jantar: _jantarBoa,
      hora_jantar: _jantarHorarioSelecionado,
      descricao_jantar: _observacoesJantarController.text,
      idpaciente: widget.paciente.idpaciente,
      idrotina: listaRotina[0].idrotina,
    );

    if (listaRefeicao.isNotEmpty) {
      refeicao.idcuidado_refeicao = listaRefeicao[0].idcuidado_refeicao;

      atualizacaoSucesso = await refeicao.atualizar();
    } else {
      atualizacaoSucesso = await refeicao.cadastrar();
    }

    showConfirmationDialog(
      context: context,
      title: atualizacaoSucesso ? 'Sucesso' : 'Erro',
      message: atualizacaoSucesso
          ? 'As informações foram salvas com sucesso!'
          : 'Houve um erro ao atualizar os dados. Por favor, tente novamente.',
      onConfirm: () {
        if (atualizacaoSucesso) {
          Navigator.of(context).pop();
        }
      },
    );
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
              "Rotina de Refeição",
              style: TextStyle(
                fontSize: 20,
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
                setState(
                  () {
                    _cafeManhaBoa = status;
                  },
                );
              },
              (TimeOfDay? selectedTime) {
                setState(() {
                  _cafeManhaHorarioSelecionado = _formatTime(selectedTime);
                });
              },
              _cafeManhaHorarioSelecionado,
            ),
            const SizedBox(height: 20),
            _buildMealWidget(
              "Almoço",
              _observacoesAlmocoController,
              _almocoBoa,
              (bool? status) {
                setState(() {
                  _almocoBoa = status;
                });
              },
              (TimeOfDay? selectedTime) {
                setState(() {
                  _almocoHorarioSelecionado = _formatTime(selectedTime);
                });
              },
              _almocoHorarioSelecionado,
            ),
            const SizedBox(height: 20),
            _buildMealWidget(
              "Jantar",
              _observacoesJantarController,
              _jantarBoa,
              (bool? status) {
                setState(() {
                  _jantarBoa = status;
                });
              },
              (TimeOfDay? selectedTime) {
                setState(() {
                  _jantarHorarioSelecionado = _formatTime(selectedTime);
                });
              },
              _jantarHorarioSelecionado,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if ((_cafeManhaBoa != null &&
                        _cafeManhaHorarioSelecionado != '00:00') ||
                    (_almocoBoa != null &&
                        _almocoHorarioSelecionado != '00:00') ||
                    (_jantarBoa != null &&
                        _jantarHorarioSelecionado != '00:00')) {
                  _salvarInformacoes();
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
