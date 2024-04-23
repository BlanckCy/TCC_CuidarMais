import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';

class Cuidado {
  int? idcuidado;
  String? data_hora;
  bool? realizado;
  int? tipo_cuidado;
  int? idpaciente;
  String? descricao;
  String? horario_realizado;
  bool? avaliacao;
  String? cuidado;
  int? idcuidado_medicacao_lista;

  Cuidado({
    this.idcuidado,
    this.data_hora,
    this.realizado,
    this.tipo_cuidado,
    this.idpaciente,
    this.descricao,
    this.horario_realizado,
    this.avaliacao,
    this.cuidado,
    this.idcuidado_medicacao_lista,
  });

  Cuidado.fromJson(Map<String, dynamic> json) {
    idcuidado = json['idcuidado'];
    data_hora = json['data_hora'];
    realizado = json['realizado'];
    tipo_cuidado = json['tipo_cuidado'];
    idpaciente = json['idpaciente'];
    descricao = json['descricao'];
    horario_realizado = json['horario_realizado'];
    avaliacao = json['avaliacao'];
    cuidado = json['cuidado'];
    idcuidado_medicacao_lista = json['idcuidado_medicacao_lista'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado'] = idcuidado;
    data['data_hora'] = data_hora;
    data['realizado'] = realizado;
    data['idpaciente'] = idpaciente;
    data['descricao'] = descricao;
    data['horario_realizado'] = horario_realizado;
    data['avaliacao'] = avaliacao;
    data['cuidado'] = cuidado;
    data['tipo_cuidado'] = tipo_cuidado;
    data['idcuidado_medicacao_lista'] = idcuidado_medicacao_lista;
    return data;
  }

  String especificartipo_cuidado() {
    switch (tipo_cuidado) {
      case 1:
        return 'Refeicao';
      case 2:
        return 'Sinais Vitais';
      case 3:
        return 'Atividade Fisica';
      case 4:
        return 'Higiene';
      case 5:
        return 'Medicacao';
      case 6:
        return 'Mudança Decúbito';
      default:
        return '';
    }
  }

  Future<bool> cadastrar() async {
    var database = Database();
    String dataHora = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print({
      'data_hora': dataHora,
      'realizado': realizado.toString(),
      'tipo_cuidado': tipo_cuidado.toString(),
      'descricao': descricao,
      'horario_realizado': horario_realizado,
      'avaliacao': avaliacao.toString(),
      'cuidado': cuidado,
      'idpaciente': idpaciente.toString(),
      'idcuidado_medicacao_lista': idcuidado_medicacao_lista.toString()
    });

    try {
      var dados = await database.buscarDadosPost('/cuidado/create', {
        'data_hora': dataHora,
        'realizado': realizado.toString(),
        'tipo_cuidado': tipo_cuidado.toString(),
        'descricao': descricao ?? '',
        'horario_realizado': horario_realizado ?? '00:00',
        'avaliacao': avaliacao.toString(),
        'cuidado': cuidado!,
        'idpaciente': idpaciente.toString(),
        'idcuidado_medicacao_lista': idcuidado_medicacao_lista.toString()
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

  Future<List<Cuidado>> carregarRotina(int tipo_cuidado, String data) async {
    var database = Database();

    print('/cuidado/lista/$idpaciente/$tipo_cuidado/$data');

    var dados = await database
        .buscarDadosGet('/cuidado/lista/$idpaciente/$tipo_cuidado/$data');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Cuidado> cuidados = cuidadosData.map((cuidadoData) {
        return Cuidado.fromJson(cuidadoData);
      }).toList();

      return cuidados;
    }

    return [];
  }

  Future<List<Cuidado>> carregarDadoEspecifico() async {
    var database = Database();

    print(
        '/cuidado/lista-cuidadomedicacao/$idpaciente/$tipo_cuidado/$idcuidado_medicacao_lista');

    var dados = await database.buscarDadosGet(
        '/cuidado/lista-cuidadomedicacao/$idpaciente/$tipo_cuidado/$idcuidado_medicacao_lista');

    var resposta = jsonDecode(dados);

    print(resposta);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Cuidado> cuidados = cuidadosData.map((cuidadoData) {
        return Cuidado.fromJson(cuidadoData);
      }).toList();

      print(cuidados);
      return cuidados;
    }

    return [];
  }

  Future<bool> atualizarDados() async {
    var database = Database();

    Map<String, dynamic> cuidadoData = toJson();
    cuidadoData['data_hora'] =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print("aqui $cuidadoData");
    try {
      var dados = await database.buscarDadosPut(
          '/cuidado/update/$idcuidado', cuidadoData);

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
