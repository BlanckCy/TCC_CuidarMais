import 'package:cuidarmais/models/rotina.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/models/tipoCuidado/medicacao.dart';
import 'package:cuidarmais/models/tipoCuidado/medicacaolista.dart';
import 'package:cuidarmais/pages/medication/medication_registration.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class MedicacaoPage extends StatefulWidget {
  final int tipoCuidado;

  const MedicacaoPage({Key? key, required this.tipoCuidado}) : super(key: key);

  @override
  State<MedicacaoPage> createState() => _MedicacaoPageState();
}

class _MedicacaoPageState extends State<MedicacaoPage> {
  List<Medicacao> medicacaoRealizado = [];
  List<MedicacaoLista> listaMedicamentos = [];
  List<Rotina> listaRotina = [];
  List<dynamic> medicamentos = [];

  bool _isLoading = true;

  late MedicacaoLista medicacaolista = MedicacaoLista();
  late Medicacao medicacao = Medicacao();
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
        cuidado: 'Medicação',
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
      medicacao.idpaciente = paciente.idpaciente;
      medicacaolista.idpaciente = paciente.idpaciente;

      listaRotina = await _validarRotina();
      medicacao.idrotina = listaRotina[0].idrotina;

      medicacaoRealizado = await medicacao.carregar();
      listaMedicamentos = await medicacaolista.carregar();

      List<Map<String, dynamic>> dadosComEstado = [];

      for (var listaM in listaMedicamentos) {
        bool realizado = false;

        for (var medicacaoR in medicacaoRealizado) {
          if (listaM.idcuidado_medicacao_lista ==
              medicacaoR.idcuidado_medicacao_lista) {
            if (medicacaoR.realizado == true) {
              realizado = true;
            }
            break;
          }
        }

        dadosComEstado.add({
          'idcuidado_medicacao_lista': listaM.idcuidado_medicacao_lista,
          'medicamento': listaM.medicamento ?? '',
          'dosagem': listaM.dosagem ?? '',
          'hora': listaM.hora ?? '',
          'tipo': listaM.tipo ?? '',
          'realizado': realizado,
          'idrotina': listaRotina[0].idrotina,
        });
      }

      setState(() {
        _isLoading = false;
        medicamentos = dadosComEstado;
        return;
      });
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
    }
  }

  Future<void> _salvarInformacoes() async {
    try {
      bool mensagem = false;

      for (var i = 0; i < medicamentos.length; i++) {
        var medicamento = medicamentos[i];
        bool atualizacaoSucesso = false;

        Medicacao medicacao = Medicacao(
          realizado: medicamento['realizado'],
          idcuidado_medicacao_lista: medicamento['idcuidado_medicacao_lista'],
          idpaciente: paciente.idpaciente,
          idrotina: medicamento['idrotina'],
        );

        if (medicacaoRealizado.isEmpty) {
          atualizacaoSucesso = await medicacao.cadastrar();
        } else {
          medicacao.idcuidado_medicacao =
              medicacaoRealizado[i].idcuidado_medicacao;
          atualizacaoSucesso = await medicacao.atualizar();
        }

        if (!mensagem) {
          mensagem = true;
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
        }
      }
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
                                        medicamentos[index]['medicamento'] ??
                                            'Sem nome',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                      Text(
                                        'Dosagem: ${medicamentos[index]['dosagem']} ${medicamentos[index]['tipo']}(s)',
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  medicamentos[index]['hora'] ?? '00:00',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Checkbox(
                                  value:
                                      medicamentos[index]['realizado'] ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      medicamentos[index]['realizado'] =
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
              Navigator.pushNamed(
                context,
                '/gerenciarMedicacao',
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
