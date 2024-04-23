import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AtividadeFisica {
  int? idcuidado_atividadefisica;
  String? descricao;
  String? hora;
  String? data_hora;
  bool? avaliacao;
  int? idpaciente;

  AtividadeFisica({
    this.idcuidado_atividadefisica,
    this.descricao,
    this.hora,
    this.data_hora,
    this.avaliacao,
    this.idpaciente,
  });

  AtividadeFisica.fromJson(Map<String, dynamic> json) {
    idcuidado_atividadefisica = json['idcuidado_atividadefisica'];
    descricao = json['descricao'];
    hora = json['hora'];
    data_hora = json['data_hora'];
    avaliacao = json['avaliacao'];
    idpaciente = json['idpaciente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado_atividadefisica'] = idcuidado_atividadefisica;
    data['descricao'] = descricao;
    data['hora'] = hora;
    data['data_hora'] = data_hora;
    data['avaliacao'] = avaliacao;
    data['idpaciente'] = idpaciente;
    return data;
  }

  Future<bool> cadastrar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print({
      'descricao': descricao ?? '',
      'avaliacao': avaliacao.toString(),
      'hora': hora ?? '00:00',
      'data_hora': dataAtual,
      'idpaciente': idpaciente.toString(),
    });

    try {
      var dados =
          await database.buscarDadosPost('/cuidado-atividadefisica/create', {
        'descricao': descricao ?? '',
        'avaliacao': avaliacao.toString(),
        'hora': hora ?? '00:00',
        'data_hora': dataAtual,
        'idpaciente': idpaciente.toString(),
      });

      var resposta = jsonDecode(dados);
      print(resposta['resposta']);

      if (resposta['resposta'] == 'erro') {
        return false;
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<AtividadeFisica>> carregar(data) async {
    var database = Database();

    print('/cuidado-atividadefisica/lista/$idpaciente/$data');

    var dados = await database
        .buscarDadosGet('/cuidado-atividadefisica/lista/$idpaciente/$data');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<AtividadeFisica> cuidados = cuidadosData.map((cuidadoData) {
        AtividadeFisica atividadefisica = AtividadeFisica.fromJson(cuidadoData);
        atividadefisica.idcuidado_atividadefisica =
            cuidadoData['idcuidadoAtividadefisica'];
        return atividadefisica;
      }).toList();

      return cuidados;
    }

    return [];
  }

  Future<bool> atualizar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    Map<String, dynamic> cuidadoData = toJson();
    cuidadoData['data_hora'] = dataAtual;

    print("aqui $cuidadoData");
    try {
      var dados = await database.buscarDadosPut(
          '/cuidado-atividadefisica/update/$idcuidado_atividadefisica',
          cuidadoData);

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

  DateTime converterDatas(TimeOfDay? timeOfDay) {
    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay?.hour ?? 0,
      timeOfDay?.minute ?? 0,
    );
  }
}
