import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Escala {
  int? idescala;
  String? data_hora;
  String? dia;
  String? hora_inicio;
  String? hora_final;
  int? idpaciente;

  Escala({
    this.idescala,
    this.data_hora,
    this.dia,
    this.hora_inicio,
    this.idpaciente,
    this.hora_final,
  });

  Escala.fromJson(Map<String, dynamic> json) {
    idescala = json['idescala'];
    data_hora = json['data_hora'];
    dia = json['dia'];
    hora_inicio = json['hora_inicio'];
    idpaciente = json['idpaciente'];
    hora_final = json['hora_final'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idescala'] = idescala;
    data['data_hora'] = data_hora;
    data['dia'] = dia;
    data['hora_inicio'] = hora_inicio;
    data['idpaciente'] = idpaciente;
    data['hora_final'] = hora_final;
    return data;
  }

  Future<bool> cadastrar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print({
      'data_hora': dataAtual,
      'dia': dia.toString(),
      'hora_inicio': hora_inicio.toString(),
      'hora_final': hora_final.toString(),
      'idpaciente': idpaciente.toString(),
    });

    try {
      var dados = await database.buscarDadosPost('/escala/create', {
        'data_hora': dataAtual,
        'dia': dia.toString(),
        'hora_inicio': hora_inicio.toString(),
        'hora_final': hora_final.toString(),
        'idpaciente': idpaciente.toString(),
      });

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

  Future<List<Escala>> carregar() async {
    var database = Database();

    print("id $idpaciente");

    var dados = await database.buscarDadosGet('/escala/lista/$idpaciente');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Escala> cuidados = cuidadosData.map((cuidadoData) {
        Escala escala = Escala.fromJson(cuidadoData);
        return escala;
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
          '/escala/update/$idescala', cuidadoData);

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
