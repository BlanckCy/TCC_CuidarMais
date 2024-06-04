import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cuidarmais/models/database.dart';
import 'package:flutter/material.dart';

class Rotina {
  int? idrotina;
  String? data_hora;
  bool? realizado;
  int? tipo_cuidado;
  String? cuidado;
  int? idpaciente;

  Rotina({
    this.idrotina,
    this.data_hora,
    this.realizado,
    this.tipo_cuidado,
    this.idpaciente,
    this.cuidado,
  });

  Rotina.fromJson(Map<String, dynamic> json) {
    idrotina = json['idrotina'];
    data_hora = json['data_hora'];
    realizado = json['realizado'];
    tipo_cuidado = json['tipo_cuidado'];
    idpaciente = json['idpaciente'];
    cuidado = json['cuidado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idrotina'] = idrotina;
    data['data_hora'] = data_hora;
    data['realizado'] = realizado;
    data['idpaciente'] = idpaciente;
    data['cuidado'] = cuidado;
    data['tipo_cuidado'] = tipo_cuidado;
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
      'cuidado': cuidado,
      'idpaciente': idpaciente.toString(),
    });

    try {
      var dados = await database.buscarDadosPost('/rotina/create', {
        'data_hora': dataHora,
        'realizado': realizado.toString(),
        'tipo_cuidado': tipo_cuidado.toString(),
        'cuidado': cuidado!,
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

  Future<List<Rotina>> carregar() async {
    var database = Database();

    print('/rotina/lista/$idpaciente/$tipo_cuidado');

    var dados = await database
        .buscarDadosGet('/rotina/lista/$idpaciente/$tipo_cuidado');

    var resposta = jsonDecode(dados);

    print(resposta['dados']);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> cuidadosData = jsonDecode(resposta['dados']);

      List<Rotina> cuidados = cuidadosData.map((cuidadoData) {
        return Rotina.fromJson(cuidadoData);
      }).toList();

      return cuidados;
    }

    return [];
  }

  Future<bool> atualizar() async {
    var database = Database();

    data_hora = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print({
      'realizado': realizado,
      'data_hora': data_hora,
      'idpaciente': idpaciente.toString()
    });

    try {
      var dados = await database.buscarDadosPut(
          '/rotina/update-rotinaAtual/$idpaciente', {
        'realizado': realizado,
        'data_hora': data_hora,
        'idpaciente': idpaciente
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

  Future<Map<String, List<dynamic>>> carregarRelatorioRotina() async {
    var database = Database();

    print('/rotina/relatorio/$idpaciente/$data_hora');

    var dados = await database
        .buscarDadosGet('/rotina/relatorio/$idpaciente/$data_hora');

    var resposta = jsonDecode(dados);

    if (resposta['resposta'] == 'ok') {
      Map<String, dynamic> jsonDataMap = jsonDecode(resposta['dados']);
      Map<String, dynamic> cuidadosMap = jsonDataMap['cuidados'];

      Map<String, List<dynamic>> dados = {};

      final tipoCuidadoMap = {
        "1": 'Refeição',
        "2": 'Sinais Vitais',
        "3": 'Atividade Física',
        "4": 'Higiene',
        "5": 'Medicação',
        "6": 'Mudança Decúbito'
      };

      for (var key in cuidadosMap.keys) {
        List<dynamic> cuidadosList = cuidadosMap[key];
        String? tipoCuidado = tipoCuidadoMap[key];
        if (tipoCuidado != null) {
          dados[tipoCuidado] = cuidadosList;
        }
      }

      print(dados);

      return dados;
    }

    return {};
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
