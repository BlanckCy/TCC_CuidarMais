import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Higiene {
  int? idcuidado_higiene;
  String? tarefa;
  String? hora;
  String? data_hora;
  int? idpaciente;

  Higiene({
    this.idcuidado_higiene,
    this.tarefa,
    this.hora,
    this.data_hora,
    this.idpaciente,
  });

  Higiene.fromJson(Map<String, dynamic> json) {
    idcuidado_higiene = json['idcuidado_higiene'];
    tarefa = json['tarefa'];
    hora = json['hora'];
    data_hora = json['data_hora'];
    idpaciente = json['idpaciente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado_higiene'] = idcuidado_higiene;
    data['tarefa'] = tarefa;
    data['hora'] = hora;
    data['data_hora'] = data_hora;
    data['idpaciente'] = idpaciente;
    return data;
  }

  Future<bool> cadastrar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    try {
      var dados = await database.buscarDadosPost('/cuidado-higiene/create', {
        'tarefa': tarefa ?? '',
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

  Future<List<Higiene>> carregar(data) async {
    var database = Database();

    print('/cuidado-higiene/lista/$idpaciente/$data');

    var dados = await database
        .buscarDadosGet('/cuidado-higiene/lista/$idpaciente/$data');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Higiene> cuidados = cuidadosData.map((cuidadoData) {
        return Higiene.fromJson(cuidadoData);
      }).toList();

      return cuidados;
    }

    return [];
  }

  Future<bool> atualizar() async {
    var database = Database();

    Map<String, dynamic> cuidadoData = toJson();

    print("aqui $cuidadoData");
    try {
      var dados = await database.buscarDadosPut(
          '/cuidado-higiene/update/$idcuidado_higiene', cuidadoData);

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
