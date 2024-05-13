import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pontoeletronico {
  int? idponto_eletronico;
  String? hora_entrada;
  String? hora_saida;
  int? idpaciente;
  int? idescala;

  Pontoeletronico({
    this.idponto_eletronico,
    this.hora_entrada,
    this.hora_saida,
    this.idpaciente,
    this.idescala,
  });

  Pontoeletronico.fromJson(Map<String, dynamic> json) {
    idponto_eletronico = json['idponto_eletronico'];
    hora_entrada = json['hora_entrada'];
    hora_saida = json['hora_saida'];
    idpaciente = json['idpaciente'];
    idescala = json['idescala'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idponto_eletronico'] = idponto_eletronico;
    data['hora_entrada'] = hora_entrada;
    data['hora_saida'] = hora_saida;
    data['idpaciente'] = idpaciente;
    data['idescala'] = idescala;
    return data;
  }

  Future<bool> cadastrar() async {
    var database = Database();

    print({
      'hora_inicio': hora_entrada.toString(),
      'hora_saida': hora_saida.toString(),
      'idpaciente': idpaciente.toString(),
      'idescala': idescala.toString()
    });

    try {
      var dados = await database.buscarDadosPost('/pontoeletronico/create', {
        'hora_entrada': hora_entrada.toString(),
        'hora_saida': hora_saida.toString(),
        'idpaciente': idpaciente.toString(),
        'idescala': idescala.toString()
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

  Future<Pontoeletronico?> carregar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print('/pontoeletronico/por-data/$idescala/$idpaciente');

    var dados = await database
        .buscarDadosGet('/pontoeletronico/por-data/$idescala/$idpaciente');

    var resposta = jsonDecode(dados);

    print('dados $resposta');

    if (resposta['resposta'] == 'ok') {
      dynamic cuidadosData = jsonDecode(resposta['dados']);

      Pontoeletronico? pontoeletronico = Pontoeletronico.fromJson(cuidadosData);
      pontoeletronico.idponto_eletronico = cuidadosData['idpontoEletronico'];

      return pontoeletronico;
    }

    return null;
  }

  Future<bool> atualizar() async {
    var database = Database();

    Map<String, dynamic> cuidadoData = toJson();

    print("aqui $cuidadoData");

    try {
      var dados = await database.buscarDadosPut(
          '/pontoeletronico/update/$idponto_eletronico', cuidadoData);

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
