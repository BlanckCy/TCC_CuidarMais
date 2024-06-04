import 'dart:convert';

import 'package:cuidarmais/models/rotina.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:cuidarmais/shared_preferences/shared_preferences.dart';
import 'package:cuidarmais/utils/gerar_pdf.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RelatorioCuidadosPage extends StatefulWidget {
  const RelatorioCuidadosPage({Key? key}) : super(key: key);

  @override
  State<RelatorioCuidadosPage> createState() => _RelatorioCuidadosState();
}

class _RelatorioCuidadosState extends State<RelatorioCuidadosPage> {
  bool _isLoading = true;
  late Paciente paciente;
  late Rotina rotina;
  pw.Document? _pdfDocument;
  DateTime? _selectedDate;

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
        _isLoading = false;
      });

      rotina = Rotina();

      // _gerarRelatorioPDF(paciente);
    } else {}
  }

  Future<Map<String, List<dynamic>>> _dadosRotina() async {
    rotina.data_hora = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    rotina.idpaciente = paciente.idpaciente;

    try {
      Map<String, List<dynamic>> resposta =
          await rotina.carregarRelatorioRotina();

      resposta['paciente'] = [
        {
          'nome': paciente.nome,
          'data': DateFormat('dd/MM/yyyy').format(_selectedDate!)
        }
      ];

      return resposta;
    } catch (e) {
      print('Erro ao carregar os dados da rotina: $e');
      return {};
    }
  }

  Future<void> _gerarRelatorioPDF() async {
    Map<String, List<dynamic>> dados = await _dadosRotina();
    final pw.Document pdf = await GerarPdf.createPdf(dados);
    setState(() {
      _pdfDocument = pdf;
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(hasPreviousRoute: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Relatório de Cuidados",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'Nenhuma data selecionada'
                              : 'Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0XFF1C51A1),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Selecionar Data'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: _selectedDate == null
                            ? null
                            : () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await _gerarRelatorioPDF();
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF1C51A1),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Gerar Relatório'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _pdfDocument != null
                      ? PdfPreview(
                          build: (format) => _pdfDocument!.save(),
                        )
                      : const Center(
                          child: Text('Nenhum relatório gerado.'),
                        ),
                ),
              ],
            ),
    );
  }
}
