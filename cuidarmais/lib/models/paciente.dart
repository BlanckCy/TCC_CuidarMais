import 'dart:convert';
import 'package:cuidarmais/models/database.dart';

class Paciente {
  int? idPaciente;
  String? nome;
  String? emailResponsavel;
  String? nomeResponsavel;
  int? idade;
  String? genero;
  int? idCuidador;
  int? idNivelCuidado;

  Paciente({
    this.idPaciente,
    this.nome,
    this.emailResponsavel,
    this.nomeResponsavel,
    this.idade,
    this.genero,
    this.idCuidador,
    this.idNivelCuidado,
  });

  Future<List<Paciente>> carregarPacientes(int idCuidador) async {
    var database = Database();
    var dados =
        await database.buscarDadosGet('/paciente/por-cuidador/$idCuidador');

    var resposta = jsonDecode(dados);

    print(resposta);

    if (resposta['resposta'] == 'ok') {
      List<dynamic> pacientesData = jsonDecode(resposta['dados']);

      print(pacientesData);

      List<Paciente> pacientes = [];
      for (var pacienteData in pacientesData) {
        pacientes.add(Paciente(
          idPaciente: pacienteData['idpaciente'],
          nome: pacienteData['nome'],
          emailResponsavel: pacienteData['email_responsavel'],
          nomeResponsavel: pacienteData['nome_responsavel'],
          idade: pacienteData['idade'],
          genero: pacienteData['genero'],
          idCuidador: pacienteData['idcuidador'],
          idNivelCuidado: pacienteData['idnivelCuidado'],
        ));
      }
      return pacientes;
    } else {
      throw Exception('Erro ao carregar pacientes');
    }
  }
}
