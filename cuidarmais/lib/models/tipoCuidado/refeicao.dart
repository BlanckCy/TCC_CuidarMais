import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Refeicao {
  int? idcuidado_refeicao;

  bool? avaliacao_cafe;
  String? hora_cafe;
  String? descricao_cafe;

  bool? avaliacao_almoco;
  String? hora_almoco;
  String? descricao_almoco;

  bool? avaliacao_jantar;
  String? hora_jantar;
  String? descricao_jantar;

  String? data_hora;
  int? idpaciente;
  int? idrotina;

  Refeicao({
    this.idcuidado_refeicao,
    this.avaliacao_cafe,
    this.hora_cafe,
    this.descricao_cafe,
    this.avaliacao_almoco,
    this.hora_almoco,
    this.descricao_almoco,
    this.avaliacao_jantar,
    this.hora_jantar,
    this.descricao_jantar,
    this.data_hora,
    this.idpaciente,
    this.idrotina,
  });

  Refeicao.fromJson(Map<String, dynamic> json) {
    idcuidado_refeicao = json['idcuidado_refeicao'];

    avaliacao_cafe = json['avaliacao_cafe'];
    hora_cafe = json['hora_cafe'];
    descricao_cafe = json['descricao_cafe'];

    avaliacao_almoco = json['avaliacao_almoco'];
    hora_almoco = json['hora_almoco'];
    descricao_almoco = json['descricao_almoco'];

    avaliacao_jantar = json['avaliacao_jantar'];
    hora_jantar = json['hora_jantar'];
    descricao_jantar = json['descricao_jantar'];

    data_hora = json['data_hora'];
    idpaciente = json['idpaciente'];
    idrotina = json['idrotina'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado_refeicao'] = idcuidado_refeicao;

    data['avaliacao_cafe'] = avaliacao_cafe;
    data['hora_cafe'] = hora_cafe;
    data['descricao_cafe'] = descricao_cafe;

    data['avaliacao_almoco'] = avaliacao_almoco;
    data['hora_almoco'] = hora_almoco;
    data['descricao_almoco'] = descricao_almoco;

    data['avaliacao_jantar'] = avaliacao_jantar;
    data['hora_jantar'] = hora_jantar;
    data['descricao_jantar'] = descricao_jantar;

    data['data_hora'] = data_hora;
    data['idpaciente'] = idpaciente;
    data['idrotina'] = idrotina;
    return data;
  }

  Future<bool> cadastrar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print({
      'avaliacao_cafe': avaliacao_cafe.toString(),
      'hora_cafe': hora_cafe ?? '00:00',
      'descricao_cafe': descricao_cafe ?? '',
      'avaliacao_almoco': avaliacao_almoco.toString(),
      'hora_almoco': hora_almoco ?? '00:00',
      'descricao_almoco': descricao_almoco ?? '',
      'avaliacao_jantar': avaliacao_jantar.toString(),
      'hora_jantar': hora_jantar ?? '00:00',
      'descricao_jantar': descricao_jantar ?? '',
      'data_hora': dataAtual,
      'idpaciente': idpaciente.toString(),
    });

    try {
      var dados = await database.buscarDadosPost('/cuidado-refeicao/create', {
        'avaliacao_cafe': avaliacao_cafe.toString(),
        'hora_cafe': hora_cafe ?? '00:00',
        'descricao_cafe': descricao_cafe ?? '',
        'avaliacao_almoco': avaliacao_almoco.toString(),
        'hora_almoco': hora_almoco ?? '00:00',
        'descricao_almoco': descricao_almoco ?? '',
        'avaliacao_jantar': avaliacao_jantar.toString(),
        'hora_jantar': hora_jantar ?? '00:00',
        'descricao_jantar': descricao_jantar ?? '',
        'data_hora': dataAtual,
        'idpaciente': idpaciente.toString(),
        'idrotina': idrotina.toString(),
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

  Future<List<Refeicao>> carregar() async {
    var database = Database();

    print('/cuidado-refeicao/lista/$idpaciente/$idrotina');

    var dados = await database
        .buscarDadosGet('/cuidado-refeicao/lista/$idpaciente/$idrotina');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Refeicao> cuidados = cuidadosData.map((cuidadoData) {
        Refeicao refeicao = Refeicao.fromJson(cuidadoData);
        refeicao.idcuidado_refeicao = cuidadoData['idcuidadoRefeicao'];
        return refeicao;
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
    // return false;
    try {
      var dados = await database.buscarDadosPut(
          '/cuidado-refeicao/update/$idcuidado_refeicao', cuidadoData);

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
