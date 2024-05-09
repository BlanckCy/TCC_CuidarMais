import 'dart:convert';

import 'package:cuidarmais/models/database.dart';

class Contatoemergencia {
  int? idcontato_emergencia;
  String? nome;
  String? telefone;
  String? parentesco;
  int? idpaciente;

  Contatoemergencia(
      {this.idcontato_emergencia,
      this.nome,
      this.telefone,
      this.parentesco,
      this.idpaciente});

  Contatoemergencia.fromJson(Map<String, dynamic> json) {
    idcontato_emergencia = json['idcontato_emergencia'];
    nome = json['nome'];
    telefone = json['telefone'];
    parentesco = json['parentesco'];
    idpaciente = json['idpaciente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcontato_emergencia'] = idcontato_emergencia;
    data['nome'] = nome;
    data['parentesco'] = parentesco;
    data['telefone'] = telefone;
    data['idpaciente'] = idpaciente;
    return data;
  }

  Future<Contatoemergencia> carregarInformacoesContato() async {
    var database = Database();
    var dados = await database
        .buscarDadosGet('/contatoemergencia/$idcontato_emergencia');

    var resposta = jsonDecode(dados);

    if (resposta['resposta'] == 'ok') {
      var contatoData = jsonDecode(resposta['dados']);

      return Contatoemergencia(
        idcontato_emergencia: contatoData['idcontatoEmergencia'],
        nome: contatoData['nome'],
        parentesco: contatoData['parentesco'],
        telefone: contatoData['telefone'],
        idpaciente: contatoData['idpaciente'],
      );
    } else {
      throw Exception('Erro ao carregar informações do contato');
    }
  }

  Future<List<Contatoemergencia>> carregarContatos() async {
    var database = Database();
    var dados = await database
        .buscarDadosGet('/contatoemergencia/por-paciente/$idpaciente');

    var resposta = jsonDecode(dados);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> contatosData = jsonDecode(resposta['dados']);

      List<Contatoemergencia> contatos = contatosData.map((contatosData) {
        Contatoemergencia contatos = Contatoemergencia.fromJson(contatosData);
        contatos.idcontato_emergencia = contatosData['idcontatoEmergencia'];
        return contatos;
      }).toList();
      return contatos;
    } else {
      throw Exception('Erro ao carregar contatos');
    }
  }

  Future<bool> cadastrar() async {
    var database = Database();

    try {
      print(idpaciente);
      if (idpaciente != null && idpaciente! > 0) {
        var dados =
            await database.buscarDadosPost('/contatoemergencia/create', {
          'nome': nome!,
          'parentesco': parentesco!,
          'telefone': telefone!,
          'idpaciente': idpaciente.toString(),
        });

        var resposta = jsonDecode(dados);
        print(resposta['resposta']);

        if (resposta['resposta'] == 'erro') {
          return false;
        }

        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<bool> atualizarDados() async {
    var database = Database();

    Map<String, dynamic> contatoData = toJson();

    print("aqui $contatoData");

    try {
      var dados = await database.buscarDadosPut(
          '/contatoemergencia/update/$idcontato_emergencia', contatoData);

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

  Future<bool> deletarContatoEmergencia() async {
    print(idcontato_emergencia);
    var database = Database();

    try {
      var dados = await database
          .buscarDadosDelete('/contatoemergencia/delete/$idcontato_emergencia');

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
}
