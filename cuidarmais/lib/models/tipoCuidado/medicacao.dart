import 'dart:convert';

import 'package:cuidarmais/models/database.dart';

class Medicacao {
  int? idcuidadoMedicacaoLista;
  String? medicamento;
  String? dosagem;
  String? hora;
  String? tipo;
  int? idpaciente;
  bool? realizada;

  Medicacao({
    this.idcuidadoMedicacaoLista,
    this.medicamento,
    this.dosagem,
    this.hora,
    this.tipo,
    this.idpaciente,
    this.realizada,
  });

  Medicacao.fromJson(Map<String, dynamic> json) {
    idcuidadoMedicacaoLista = json['idcuidadoMedicacaoLista'];
    medicamento = json['medicamento'];
    dosagem = json['dosagem'];
    hora = json['hora'];
    tipo = json['tipo'];
    idpaciente = json['idpaciente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidadoMedicacaoLista'] = idcuidadoMedicacaoLista;
    data['medicamento'] = medicamento;
    data['dosagem'] = dosagem;
    data['idpaciente'] = idpaciente;
    data['hora'] = hora;
    data['tipo'] = tipo;
    return data;
  }

  Future<List<Medicacao>> carregarMedicamentos(int idpaciente) async {
    var database = Database();

    print('/medicacao/lista/$idpaciente');

    var dados = await database.buscarDadosGet('/medicacao/lista/$idpaciente');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);
    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Medicacao> medicamentos = cuidadosData.map((cuidadoData) {
        return Medicacao.fromJson(cuidadoData);
      }).toList();

      return medicamentos;
    }

    return [];
  }

  Future<bool> cadastrar() async {
    var database = Database();

    try {
      var dados = await database.buscarDadosPost('/medicacao/create', {
        'medicamento': medicamento!,
        'hora': hora!,
        'dosagem': dosagem!,
        'tipo': tipo!,
        'idpaciente': idpaciente.toString(),
      });

      var resposta = jsonDecode(dados);
      print(resposta['resposta']);

      if (resposta['resposta'] == 'ok') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Erro ao cadastrar medicamento: $error');
      return false;
    }
  }
}
