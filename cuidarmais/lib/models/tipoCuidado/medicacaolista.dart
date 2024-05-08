import 'dart:convert';

import 'package:cuidarmais/models/database.dart';

class MedicacaoLista {
  int? idcuidado_medicacao_lista;
  String? medicamento;
  String? dosagem;
  String? hora;
  String? tipo;
  int? idpaciente;

  MedicacaoLista({
    this.idcuidado_medicacao_lista,
    this.medicamento,
    this.dosagem,
    this.hora,
    this.tipo,
    this.idpaciente,
  });

  MedicacaoLista.fromJson(Map<String, dynamic> json) {
    idcuidado_medicacao_lista = json['idcuidado_medicacao_lista'];
    medicamento = json['medicamento'];
    dosagem = json['dosagem'];
    hora = json['hora'];
    tipo = json['tipo'];
    idpaciente = json['idpaciente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado_medicacao_lista'] = idcuidado_medicacao_lista;
    data['medicamento'] = medicamento;
    data['dosagem'] = dosagem;
    data['idpaciente'] = idpaciente;
    data['hora'] = hora;
    data['tipo'] = tipo;
    return data;
  }

  Future<List<MedicacaoLista>> carregar() async {
    var database = Database();

    print('/cuidado-medicacaolista/lista/$idpaciente');

    var dados = await database
        .buscarDadosGet('/cuidado-medicacaolista/lista/$idpaciente');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);
    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<MedicacaoLista> medicamentos = cuidadosData.map((cuidadoData) {
        MedicacaoLista medicacaolista = MedicacaoLista.fromJson(cuidadoData);
        medicacaolista.idcuidado_medicacao_lista =
            cuidadoData['idcuidadoMedicacaoLista'];
        return medicacaolista;
      }).toList();

      return medicamentos;
    }

    return [];
  }

  Future<bool> cadastrar() async {
    var database = Database();

    try {
      var dados =
          await database.buscarDadosPost('/cuidado-medicacaolista/create', {
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
