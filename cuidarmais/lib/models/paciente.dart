import 'dart:convert';
import 'package:cuidarmais/models/database.dart';

class Paciente {
  int? idpaciente;
  String? nome;
  String? email_responsavel;
  String? nome_responsavel;
  int? idade;
  String? genero;
  int? idcuidador;
  int? idnivelcuidado;

  Paciente({
    this.idpaciente,
    this.nome,
    this.email_responsavel,
    this.nome_responsavel,
    this.idade,
    this.genero,
    this.idcuidador,
    this.idnivelcuidado,
  });

  Paciente.fromJson(Map<String, dynamic> json) {
    idpaciente = json['idpaciente'];
    nome = json['nome'];
    email_responsavel = json['email_responsavel'];
    nome_responsavel = json['nome_responsavel'];
    idade = json['idade'];
    genero = json['genero'];
    idcuidador = json['idcuidador'];
    idnivelcuidado = json['idnivelcuidado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idpaciente'] = idpaciente;
    data['nome'] = nome;
    data['email_responsavel'] = email_responsavel;
    data['nome_responsavel'] = nome_responsavel;
    data['idade'] = idade;
    data['genero'] = _formatarGeneroInicial(genero);
    data['idcuidador'] = idcuidador;
    data['idnivelcuidado'] = idnivelcuidado;
    return data;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  Future<List<Paciente>> carregarPacientes(int idcuidador) async {
    var database = Database();
    var dados =
        await database.buscarDadosGet('/paciente/por-cuidador/$idcuidador');

    var resposta = jsonDecode(dados);

    print(resposta);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> pacientesData = jsonDecode(resposta['dados']);

      print(pacientesData);

      List<Paciente> pacientes = [];
      for (var pacienteData in pacientesData) {
        String? generoFormatado = _formatarGenero(pacienteData['genero']);

        pacientes.add(Paciente(
          idpaciente: pacienteData['idpaciente'],
          nome: pacienteData['nome'],
          email_responsavel: pacienteData['email_responsavel'],
          nome_responsavel: pacienteData['nome_responsavel'],
          idade: pacienteData['idade'],
          genero: generoFormatado,
          idcuidador: pacienteData['idcuidador'],
          idnivelcuidado: pacienteData['idnivelcuidado'],
        ));
      }
      return pacientes;
    } else {
      throw Exception('Erro ao carregar pacientes');
    }
  }

  Future<bool> salvarDados(int idpaciente) async {
    var database = Database();

    Map<String, dynamic> pacienteData = toJson();
    pacienteData['idpaciente'] = idpaciente;

    try {
      var dados = await database.buscarDadosPut(
          '/paciente/update/$idpaciente', pacienteData);

      print(idpaciente);
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

  Future<bool> deletarPaciente(int idpaciente) async {
    var database = Database();

    try {
      var dados =
          await database.buscarDadosDelete('/paciente/delete/$idpaciente');

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

  Future<bool> cadastrar(int idcuidador) async {
    var database = Database();

    genero = _formatarGeneroInicial(genero);

    try {
      var dados = await database.buscarDadosPost('/paciente/create', {
        'nome': nome!,
        'idade': idade.toString(),
        'genero': genero!,
        'nome_responsavel': nome_responsavel!,
        'email_responsavel': email_responsavel!,
        'idcuidador': idcuidador.toString(),
        'idnivelcuidado': '1'
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

  String? _formatarGenero(String? genero) {
    if (genero != null) {
      if (genero.toLowerCase() == 'm') {
        return 'Masculino';
      } else if (genero.toLowerCase() == 'f') {
        return 'Feminino';
      } else if (genero.toLowerCase() == 'o') {
        return 'Outro';
      }
    }
    return null;
  }

  String? _formatarGeneroInicial(String? genero) {
    if (genero != null) {
      if (genero.toLowerCase() == 'feminino') {
        return 'F';
      } else if (genero.toLowerCase() == 'masculino') {
        return 'M';
      } else if (genero.toLowerCase() == 'outro') {
        return 'O';
      }
    }
    return null;
  }
}
