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
                'Nome: ${rotinas['paciente']?[0]['nome'] ?? 'Não Realizado.'}',
                style: const pw.TextStyle(
                  fontSize: 14.0,
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Data: ${rotinas['paciente']?[0]['data'] ?? 'Não Realizado.'}',
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
                            'Café da Manhã: ${rotina['hora_cafe'] != null ? '${rotina['descricao_cafe']?.isEmpty ?? true ? 'Sem Descrição' : rotina['descricao_cafe']} - Hora: ${rotina['hora_cafe']} - ${rotina['avaliacao_cafe'] == true ? 'Se alimentou bem' : 'Não se alimentou bem'}' : 'Não realizado.'}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Almoço: ${rotina['hora_almoco'] != null ? '${rotina['descricao_almoco']?.isEmpty ?? true ? 'Sem Descrição' : rotina['descricao_almoco']} - Hora: ${rotina['hora_almoco']} - ${rotina['avaliacao_almoco'] == true ? 'Se alimentou bem' : 'Não se alimentou bem'}' : 'Não realizado.'}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Jantar: ${rotina['hora_jantar'] != null ? '${rotina['descricao_jantar']?.isEmpty ?? true ? 'Sem Descrição' : rotina['descricao_jantar']} - Hora: ${rotina['hora_jantar']} - ${rotina['avaliacao_jantar'] == true ? 'Se alimentou bem' : 'Não se alimentou bem'}' : 'Não realizado.'}',
                          ),
                        ],
                      ),
                    if (entry.key == 'Sinais Vitais')
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Pressão: ${rotina['pressao_sistolica'] == null || rotina['pressao_diastolica'] == null ? 'Não Realizado.' : '${rotina['pressao_sistolica']} / ${rotina['pressao_diastolica']} mmHg'}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Temperatura: ${(rotina['temperatura']?.isEmpty ?? true ? 'Não Realizado.' : rotina['temperatura'] + ' ºC')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Frequência Respiratória: ${(rotina['frequencia_respiratoria']?.isEmpty ?? true ? 'Não Realizado.' : rotina['frequencia_respiratoria'] + ' IRPM')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Frequência Cardíaca: ${(rotina['frequencia_cardiaca']?.isEmpty ?? true ? 'Não Realizado.' : rotina['frequencia_cardiaca'] + ' BPM')}',
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'Descrição: ${(rotina['descricao_sinais_vitais']?.isEmpty ?? true ? 'Sem descrição' : rotina['descricao_sinais_vitais'])}',
                          ),
                        ],
                      ),
                    if (entry.key == 'Atividade Física')
                      pw.Text(
                        rotina['hora_atividade_fisica'] != null
                            ? 'Descrição: ${(rotina['descricao_atividade_fisica']?.isEmpty ?? true ? 'Sem descrição' : rotina['descricao_atividade_fisica'])} - ${rotina['hora_atividade_fisica'] ?? 'Não Realizado.'} - ${(rotina['avaliacao_atividade_fisica'] == true ? 'Se exercitou bem' : 'Não se exercitou bem')}'
                            : 'Não Realizado.',
                      ),
                    if (entry.key == 'Higiene')
                      pw.Text(
                        rotina['tarefa_higiene'] != null
                            ? 'Tarefa: ${rotina['tarefa_higiene']} - ${rotina['hora_higiene']}'
                            : 'Não Realizado.',
                      ),
                    if (entry.key == 'Medicação')
                      pw.Text(
                        'Medicamento: ${rotina['medicamento'] ?? ''} - ${(rotina['realizado_medicamento'] == true ? 'Realizado' : 'Não Realizado.')}',
                      ),
                    if (entry.key == 'Mudança Decúbito')
                      pw.Text(
                        rotina['hora_mudancadecubito'] != null
                            ? 'Mudança Decúbito: ${rotina['mudanca_decubito']} - ${rotina['hora_mudancadecubito']}'
                            : 'Não Realizado.',
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
