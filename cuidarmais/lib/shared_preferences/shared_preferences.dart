import 'dart:convert';

import 'package:cuidarmais/models/cuidador.dart';
import 'package:cuidarmais/models/paciente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PacienteSharedPreferences {
  static const _chavePaciente = 'paciente';

  static Future<void> salvarPaciente(Paciente paciente) async {
    final prefs = await SharedPreferences.getInstance();
    await limparPaciente();
    final pacienteJson = jsonEncode(paciente.toJson());
    await prefs.setString(_chavePaciente, pacienteJson);
  }

  static Future<Paciente?> recuperarPaciente() async {
    final prefs = await SharedPreferences.getInstance();
    final pacienteJson = prefs.getString(_chavePaciente);
    if (pacienteJson != null) {
      final pacienteMap = jsonDecode(pacienteJson);
      return Paciente.fromJson(pacienteMap);
    }
    return null;
  }

  static Future<void> limparPaciente() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chavePaciente);
  }
}

class CuidadorSharedPreferences {
  static const _chave = 'cuidador';

  static Future<void> salvar(Cuidador cuidador) async {
    final prefs = await SharedPreferences.getInstance();
    await limpar();
    final dadosJson = jsonEncode(cuidador.toJson());
    await prefs.setString(_chave, dadosJson);
  }

  static Future<Cuidador?> recuperar() async {
    final prefs = await SharedPreferences.getInstance();
    final dadosJson = prefs.getString(_chave);
    if (dadosJson != null) {
      final dadosMap = jsonDecode(dadosJson);
      return Cuidador.fromJson(dadosMap);
    }
    return null;
  }

  static Future<void> limpar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chave);
  }
}
