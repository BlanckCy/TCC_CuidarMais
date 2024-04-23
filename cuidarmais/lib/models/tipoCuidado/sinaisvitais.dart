import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SinaisVitais {
  int? idcuidado_sinaisvitais;
  String? pressao_sistolica;
  String? pressao_diastolica;
  String? temperatura;
  String? frequencia_respiratoria;
  String? frequencia_cardiaca;
  String? data_hora;
  String? descricao;
  int? idpaciente;

  SinaisVitais({
    this.idcuidado_sinaisvitais,
    this.pressao_diastolica,
    this.pressao_sistolica,
    this.temperatura,
    this.frequencia_cardiaca,
    this.frequencia_respiratoria,
    this.data_hora,
    this.descricao,
    this.idpaciente,
  });

  SinaisVitais.fromJson(Map<String, dynamic> json) {
    idcuidado_sinaisvitais = json['idcuidado_sinaisvitais'];
    pressao_diastolica = json['pressao_diastolica'];
    pressao_sistolica = json['pressao_sistolica'];
    temperatura = json['temperatura'];
    frequencia_cardiaca = json['frequencia_cardiaca'];
    frequencia_respiratoria = json['frequencia_respiratoria'];
    data_hora = json['data_hora'];
    descricao = json['descricao'];
    idpaciente = json['idpaciente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado_sinaisvitais'] = idcuidado_sinaisvitais;
    data['pressao_diastolica'] = pressao_diastolica;
    data['pressao_sistolica'] = pressao_sistolica;
    data['temperatura'] = temperatura;
    data['frequencia_cardiaca'] = frequencia_cardiaca;
    data['frequencia_respiratoria'] = frequencia_respiratoria;
    data['data_hora'] = data_hora;
    data['descricao'] = descricao;
    data['idpaciente'] = idpaciente;
    return data;
  }

  Future<bool> cadastrar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print({
      'pressao_diastolica': pressao_diastolica,
      'pressao_sistolica': pressao_sistolica,
      'temperatura': temperatura,
      'frequencia_cardiaca': frequencia_cardiaca,
      'frequencia_respiratoria': frequencia_respiratoria,
      'descricao': descricao,
      'data_hora': dataAtual,
      'idpaciente': idpaciente.toString(),
    });

    try {
      var dados =
          await database.buscarDadosPost('/cuidado-sinaisvitais/create', {
        'pressao_diastolica': pressao_diastolica ?? '',
        'pressao_sistolica': pressao_sistolica ?? '',
        'temperatura': temperatura ?? '',
        'frequencia_cardiaca': frequencia_cardiaca ?? '',
        'frequencia_respiratoria': frequencia_respiratoria ?? '',
        'descricao': descricao ?? '',
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

  Future<List<SinaisVitais>> carregar(data) async {
    var database = Database();

    print('/cuidado-sinaisvitais/lista/$idpaciente/$data');

    var dados = await database
        .buscarDadosGet('/cuidado-sinaisvitais/lista/$idpaciente/$data');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<SinaisVitais> cuidados = cuidadosData.map((cuidadoData) {
        SinaisVitais sinaisVitais = SinaisVitais.fromJson(cuidadoData);
        sinaisVitais.idcuidado_sinaisvitais =
            cuidadoData['idcuidadoSinaisvitais'];
        return sinaisVitais;
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

    try {
      var dados = await database.buscarDadosPut(
          '/cuidado-sinaisvitais/update/$idcuidado_sinaisvitais', cuidadoData);

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
