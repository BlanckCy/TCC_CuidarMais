import 'dart:convert';

import 'package:cuidarmais/models/database.dart';

class Cuidador {
  int? idcuidador;
  String? nome;
  String? email;
  String? senha;
  bool? manter;
  String? genero;
  int? idade;

  Cuidador({idcuidador, nome, email, senha, manter, genero, idade});

  Cuidador.fromJson(Map<String, dynamic> json) {
    idcuidador = json['idcuidador'];
    nome = json['nome'];
    email = json['email'];
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

  Future<bool> isValid(String email, String senha) async {
    try {
      var dados = await Database.buscarDadosPost(
          '/cuidadores/login', {'email': email, 'senha': senha});

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
