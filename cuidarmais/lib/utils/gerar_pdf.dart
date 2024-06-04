import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GerarPdf {
  static Future<pw.Document> createPdf(
      Map<String, List<dynamic>> rotinas) async {
    // Crie o documento PDF
    final pdf = pw.Document();

    // Carregue a imagem do asset
    final Uint8List imageBytes =
        (await rootBundle.load('assets/logo-vertical.png'))
            .buffer
            .asUint8List();

    // Adicione conteúdo ao PDF
    pdf.addPage(
      pw.MultiPage(
        footer: (context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Text(
              'Página ${context.pageNumber} de ${context.pagesCount}',
              style: const pw.TextStyle(color: PdfColors.grey),
            ),
          );
        },
        build: (context) => [
          pw.Row(
            children: [
              pw.Container(
                width: 60,
                height: 60,
                decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                    image: pw.MemoryImage(imageBytes),
                  ),
                ),
              ),
              pw.SizedBox(width: 100),
              pw.Text(
                'Relatório de Cuidados',
                style: pw.TextStyle(
                  fontSize: 18.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Container(
            margin: const pw.EdgeInsets.symmetric(vertical: 5.0),
            height: 1.0,
            color: PdfColors.grey,
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Text(
                'Nome: ${rotinas['paciente']![0]['nome']}',
                style: const pw.TextStyle(
                  fontSize: 14.0,
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Data: ${rotinas['paciente']![0]['data']}',
                style: const pw.TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          ...rotinas.entries
              .where((entry) => entry.key != 'paciente')
              .expand((entry) {
            return [
              pw.Text(
                entry.key,
                style: pw.TextStyle(
                  fontSize: 14.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              ...entry.value.map((rotina) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (entry.key == 'Refeição')
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Café da Manhã: ${(rotina['descricao_cafe'].isEmpty ? 'Sem Descrição' : rotina['descricao_cafe'])} - Hora: ${rotina['hora_cafe']} - ${(rotina['avaliacao_cafe'] ? 'Se alimentou bem' : 'Não se alimentou bem')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Almoço: ${(rotina['descricao_almoco'].isEmpty ? 'Sem Descrição' : rotina['descricao_almoco'])} - Hora: ${rotina['hora_almoco']} - ${(rotina['avaliacao_almoco'] ? 'Se alimentou bem' : 'Não se alimentou bem')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Jantar: ${(rotina['descricao_jantar'].isEmpty ? 'Sem Descrição' : rotina['descricao_jantar'])} - Hora: ${rotina['hora_jantar']} - ${(rotina['avaliacao_jantar'] ? 'Se alimentou bem' : 'Não se alimentou bem')}',
                          ),
                        ],
                      ),
                    if (entry.key == 'Sinais Vitais')
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Pressão: ${rotina['pressao_sistolica']} / ${rotina['pressao_diastolica']} mmHg',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Temperatura: ${(rotina['temperatura'].isEmpty ? 'Não informardo' : rotina['temperatura'] + ' ºC')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Frequência Respiratória: ${(rotina['frequencia_respiratoria'].isEmpty ? 'Não informardo' : rotina['frequencia_respiratoria'] + ' IRPM')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Frequência Cardíaca: ${(rotina['frequencia_cardiaca'].isEmpty ? 'Não informardo' : rotina['frequencia_cardiaca'] + ' BPM')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Descrição: ${(rotina['descricao_sinais_vitais'].isEmpty ? 'Sem descrição' : rotina['descricao_sinais_vitais'])}',
                          ),
                        ],
                      ),
                    if (entry.key == 'Atividade Física')
                      pw.Text(
                        'Descrição: ${(rotina['descricao_atividade_fisica'].isEmpty ? 'Sem descrição' : rotina['descricao_atividade_fisica'])} - ${rotina['hora_atividade_fisica']} - ${(rotina['avaliacao_atividade_fisica'] ? 'Se exercitou bem' : 'Não se exercitou bem')}',
                      ),
                    if (entry.key == 'Higiene')
                      pw.Text(
                        'Tarefa: ${rotina['tarefa_higiene']} - ${rotina['hora_higiene']}',
                      ),
                    if (entry.key == 'Medicação')
                      pw.Text(
                        'Medicamento: ${rotina['medicamento']} - ${(rotina['realizado_medicamento'] ? 'Realizado' : 'Não Realizado')}',
                      ),
                    if (entry.key == 'Mudança Decúbito')
                      pw.Text(
                        'Mudança Decúbito: ${rotina['mudanca_decubito']} - ${rotina['hora_mudancadecubito']}',
                      ),
                    pw.SizedBox(height: 5),
                  ],
                );
              }),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 5.0),
                height: 1.0,
                color: PdfColors.grey,
              ),
            ];
          }),
        ],
      ),
    );

    return pdf;
  }
}
