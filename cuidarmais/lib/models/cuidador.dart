import 'dart:convert';

import 'package:cuidarmais/models/database.dart';

class Cuidador {
  int? idcuidador;
  String? nome;
  String? email;
  String? telefone;
  String? senha;
  bool? manter;
  String? genero;
  int? idade;

  Cuidador(
      {this.idcuidador,
      this.nome,
      this.email,
      this.telefone,
      this.senha,
      this.manter,
      this.genero,
      this.idade});

  Cuidador.fromJson(Map<String, dynamic> json) {
    idcuidador = json['idcuidador'];
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    senha = json['senha'];
    manter = json['manter'];
    genero = json['genero'];
    idade = json['idade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcuidador'] = idcuidador;
    data['nome'] = nome;
    data['email'] = email;
    data['senha'] = senha;
    data['manter'] = manter;
    data['genero'] = genero;
    data['idade'] = idade;
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

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    if (value.length < 8) {
      return 'Deve ter pelo menos 8 caracteres';
    }
    if (!value.contains(RegExp(r'\d'))) {
      return 'Deve conter pelo menos um número';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Deve conter pelo menos um caracter especial';
    }
    return null;
  }

  String? validateTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu número';
    }

    return null;
  }

  Future<Map<String, dynamic>> isValid(String email, String senha) async {
    var database = Database();

    try {
      var dados = await database
          .buscarDadosPost('/cuidador/login', {'email': email.trim(), 'senha': senha});

      var resposta = jsonDecode(dados);
      var dadosCuidador = jsonDecode(resposta['dados']);

      print("cuidador $resposta");

      if (resposta['resposta'] == 'ok') {
        return {
          'resposta': true,
          'dados': dadosCuidador,
        };
      } else {
        return {'resposta': false, 'dados': null};
      }
    } catch (error) {
      return {'resposta': false, 'dados': null};
    }
  }

  Future<bool> cadastrar() async {
    var database = Database();

    print('email: $email');
    genero = _formatarGenero(genero);

    try {
      var dados = await database.buscarDadosPost('/cuidador/create', {
        'nome': nome!,
        'idade': idade.toString(),
        'genero': genero!,
        'telefone': telefone!,
        'email': email!,
        'senha': senha!,
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
      if (genero.toLowerCase() == 'masculino') {
        return 'M';
      } else if (genero.toLowerCase() == 'feminino') {
        return 'F';
      } else if (genero.toLowerCase() == 'outro') {
        return 'O';
      }
    }
    return null;
  }
}
