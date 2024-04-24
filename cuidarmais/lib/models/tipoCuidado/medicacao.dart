import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:intl/intl.dart';

class Medicacao {
  int? idcuidado_medicacao;
  String? data_hora;
  int? idcuidado_medicacao_lista;
  bool? realizado;
  int? idpaciente;
  int? idrotina;

  Medicacao({
    this.idcuidado_medicacao,
    this.data_hora,
    this.idcuidado_medicacao_lista,
    this.realizado,
    this.idpaciente,
    this.idrotina,
  });

  Medicacao.fromJson(Map<String, dynamic> json) {
    idcuidado_medicacao = json['idcuidado_medicacao'];
    data_hora = json['data_hora'];
    idcuidado_medicacao_lista = json['idcuidado_medicacao_lista'];
    realizado = json['realizado'];
    idpaciente = json['idpaciente'];
    idrotina = json['idrotina'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado_medicacao'] = idcuidado_medicacao;
    data['data_hora'] = data_hora;
    data['idcuidado_medicacao_lista'] = idcuidado_medicacao_lista;
    data['realizado'] = realizado;
    data['idpaciente'] = idpaciente;
    data['idrotina'] = idrotina;
    return data;
  }

  Future<List<Medicacao>> carregar() async {
    var database = Database();

    print('/cuidado-medicacao/lista/$idpaciente/$idrotina');

    var dados =
        await database.buscarDadosGet('/cuidado-medicacao/lista/$idpaciente/$idrotina');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);
    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Medicacao> medicamentos = cuidadosData.map((cuidadoData) {
        Medicacao medicacao = Medicacao.fromJson(cuidadoData);
        medicacao.idcuidado_medicacao = cuidadoData['idcuidadoMedicacao'];
        return medicacao;
      }).toList();

      return medicamentos;
    }

    return [];
  }

  Future<bool> cadastrar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print(
      {
        'data_hora': dataAtual,
        'realizado': realizado.toString(),
        'idcuidado_medicacao_lista': idcuidado_medicacao_lista.toString(),
        'idpaciente': idpaciente.toString(),
        'idrotina': idrotina.toString()
      },
    );

    // return false;

    try {
      var dados = await database.buscarDadosPost('/cuidado-medicacao/create', {
        'data_hora': dataAtual,
        'realizado': realizado.toString(),
        'idcuidado_medicacao_lista': idcuidado_medicacao_lista.toString(),
        'idpaciente': idpaciente.toString(),
        'idrotina': idrotina.toString(),
      });

      var resposta = jsonDecode(dados);
      print(resposta['resposta']);

      if (resposta['resposta'] == 'ok') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Erro ao cadastrar data_hora: $error');
      return false;
    }
  }

  Future<bool> atualizar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    Map<String, dynamic> cuidadoData = toJson();
    cuidadoData['data_hora'] = dataAtual;

    print("aqui $cuidadoData");
    try {
      var dados = await database.buscarDadosPut(
          '/cuidado-medicacao/update/$idcuidado_medicacao', cuidadoData);

      var resposta = jsonDecode(dados);
      print(resposta);

      if (resposta['resposta'] == 'erro') {
        return false;
      }

      return true;
    } catch (error) {
      return false;
    }
  }
}
