import 'dart:convert';

import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MudancaDecubito {
  int? idcuidado_mudancadecubito;
  String? mudanca;
  String? hora;
  String? data_hora;
  int? idpaciente;
  int? idrotina;

  MudancaDecubito({
    this.idcuidado_mudancadecubito,
    this.mudanca,
    this.hora,
    this.data_hora,
    this.idpaciente,
    this.idrotina,
  });

  MudancaDecubito.fromJson(Map<String, dynamic> json) {
    idcuidado_mudancadecubito = json['idcuidado_mudancadecubito'];
    mudanca = json['mudanca'];
    hora = json['hora'];
    data_hora = json['data_hora'];
    idpaciente = json['idpaciente'];
    idrotina = json['idrotina'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidado_mudancadecubito'] = idcuidado_mudancadecubito;
    data['mudanca'] = mudanca;
    data['hora'] = hora;
    data['data_hora'] = data_hora;
    data['idpaciente'] = idpaciente;
    data['idrotina'] = idrotina;
    return data;
  }

  Future<bool> cadastrar() async {
    var database = Database();

    String dataAtual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    try {
      var dados =
          await database.buscarDadosPost('/cuidado-mudancadecubito/create', {
        'mudanca': mudanca ?? '',
        'hora': hora ?? '00:00',
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

  Future<List<MudancaDecubito>> carregar() async {
    var database = Database();

    print('/cuidado-mudancadecubito/lista/$idpaciente/$idrotina');

    var dados = await database
        .buscarDadosGet('/cuidado-mudancadecubito/lista/$idpaciente/$idrotina');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<MudancaDecubito> cuidados = cuidadosData.map((cuidadoData) {
        MudancaDecubito mudancaDecubito = MudancaDecubito.fromJson(cuidadoData);
        mudancaDecubito.idcuidado_mudancadecubito =
            cuidadoData['idcuidadoMudancadecubito'];
        return mudancaDecubito;
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
          '/cuidado-mudancadecubito/update/$idcuidado_mudancadecubito',
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
