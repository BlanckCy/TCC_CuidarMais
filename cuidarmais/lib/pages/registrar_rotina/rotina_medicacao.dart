import 'package:cuidarmais/models/cuidado.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/tipoCuidado/medicacao.dart';
import 'package:cuidarmais/pages/medication/medication_registration.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:intl/intl.dart';

class MedicacaoPage extends StatefulWidget {
  final Paciente paciente;
  final int tipoCuidado;

  const MedicacaoPage(
      {Key? key, required this.paciente, required this.tipoCuidado})
      : super(key: key);

  @override
  State<MedicacaoPage> createState() => _MedicacaoPageState();
}

class _MedicacaoPageState extends State<MedicacaoPage> {
  List<Cuidado> cuidadoRealizado = [];
  List<Medicacao> medicamentos = [];
  bool _isLoading = true;

  late Cuidado cuidado = Cuidado();
  late Medicacao medicacao = Medicacao();

  @override
  void initState() {
    super.initState();
    String dataFormatada = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _carregarMedicamentos(
        tipo_cuidado: widget.tipoCuidado, data: dataFormatada);
  }

  Future<void> _carregarMedicamentos({
    required int tipo_cuidado,
    required String data,
  }) async {
    try {
      cuidado.idpaciente = widget.paciente.idpaciente;
      var listaCuidado = await cuidado.carregarRotina(tipo_cuidado, data);
      var listaMedicamentos =
          await medicacao.carregarMedicamentos(widget.paciente.idpaciente ?? 0);
      setState(() {
        cuidadoRealizado = listaCuidado;
        medicamentos = listaMedicamentos;
        _isLoading = false;

        for (var medicamento in medicamentos) {
          medicamento.realizada = false;
          for (var cuidado in cuidadoRealizado) {
            if (cuidado.idcuidado_medicacao_lista ==
                medicamento.idcuidadoMedicacaoLista) {
              if (cuidado.realizado == true) {
                medicamento.realizada = true;
              }

              break;
            }
          }
        }
      });
    } catch (error) {
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
      for (var medicamento in medicamentos) {
        bool atualizacaoSucesso = false;

        Cuidado cuidado = Cuidado(
          tipo_cuidado: 6,
          idcuidado_medicacao_lista: medicamento.idcuidadoMedicacaoLista,
          realizado: medicamento.realizada,
          cuidado: "Medicação",
          idpaciente: widget.paciente.idpaciente,
        );

        List<Cuidado> cadastroExistente = [];

        cadastroExistente = await cuidado.carregarDadoEspecifico();
        if (cadastroExistente.isNotEmpty) {
          cuidado = cadastroExistente.first;
          cuidado.realizado = medicamento.realizada;
          atualizacaoSucesso = await cuidado.atualizarDados();
        }

        if (medicamento.realizada == true) {
          if (cadastroExistente.isEmpty) {
            atualizacaoSucesso = await cuidado.cadastrar();
          }
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
      }
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
          : _buildMedicamentosList(),
    );
  }

  Widget _buildMedicamentosList() {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Rotina de Medicação",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Marque os medicamentos que já foram administrados.",
            style: TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        'Medicação',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 80),
                      Text(
                        'Horário',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Realizado?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: medicamentos.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        medicamentos[index].medicamento ??
                                            'Sem nome',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                      Text(
                                        'Dosagem: ${medicamentos[index].dosagem} ${medicamentos[index].tipo}(s)',
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  medicamentos[index].hora ?? '00:00',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Checkbox(
                                  value: medicamentos[index].realizada ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      medicamentos[index].realizada =
                                          value ?? false;
                                    });
                                  },
                                  activeColor: const Color(0XFF1C51A1),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicationRegistrationPage(
                    paciente: widget.paciente,
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0XFF1C51A1),
              foregroundColor: Colors.white,
              minimumSize: const Size(250, 50),
            ),
            child: const Text("Adicionar Novo Medicamento"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _salvarInformacoes();
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
}
