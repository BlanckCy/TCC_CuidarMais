import 'package:http/http.dart' as http;
import 'dart:convert';

class Database {
  String? ip = ""; // adicionar IP da máquina

  Future<String> buscarDadosGet(String endpoint) async {
    var url = Uri.http('$ip:8070', endpoint);
    try {
      var resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        return jsonEncode(
            {'resposta': 'ok', 'dados': utf8.decode(resposta.bodyBytes)});
      } else {
        return jsonEncode({
          'resposta': 'erro',
          'mensagem':
              'Informação não econtrada. Código de status: ${resposta.statusCode}'
        });
      }
    } catch (e) {
      return jsonEncode({'resposta': 'erro', 'mensagem': '$e'});
    }
  }

  Future<String> buscarDadosPost(
      String endpoint, Map<String, String> parametros) async {
    var url = Uri.http('$ip:8070', endpoint);

    try {
      var resposta = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(parametros),
      );

      if (resposta.statusCode == 200 || resposta.statusCode == 201) {
        return jsonEncode(
            {'resposta': 'ok', 'dados': utf8.decode(resposta.bodyBytes)});
      } else {
        return jsonEncode({
          'resposta': 'erro',
          'mensagem':
              'Informação não econtrada. Código de status: ${resposta.statusCode}'
        });
      }
    } catch (e) {
      return jsonEncode({'resposta': 'erro', 'mensagem': '$e'});
    }
  }

  Future<String> buscarDadosPut(
      String endpoint, Map<String, dynamic> parametros) async {
    var url = Uri.http('$ip:8070', endpoint);
    try {
      var resposta = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(parametros),
      );

      print("pa $parametros");

      if (resposta.statusCode == 200) {
        return jsonEncode(
            {'resposta': 'ok', 'dados': utf8.decode(resposta.bodyBytes)});
      } else {
        return jsonEncode({
          'resposta': 'erro',
          'mensagem':
              'Informação não encontrada. Código de status: ${resposta.statusCode}'
        });
      }
    } catch (e) {
      return jsonEncode({'resposta': 'erro', 'mensagem': '$e'});
    }
  }

  Future<String> buscarDadosDelete(String endpoint) async {
    var url = Uri.http('$ip:8070', endpoint);
    try {
      var resposta = await http.delete(url);

      if (resposta.statusCode == 204) {
        return jsonEncode({'resposta': 'ok'});
      } else {
        return jsonEncode({
          'resposta': 'erro',
          'mensagem':
              'Informação não encontrada. Código de status: ${resposta.statusCode}'
        });
      }
    } catch (e) {
      return jsonEncode({'resposta': 'erro', 'mensagem': '$e'});
    }
  }
}
