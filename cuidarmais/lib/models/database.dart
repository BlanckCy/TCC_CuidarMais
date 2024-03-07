import 'package:http/http.dart' as http;
import 'dart:convert';

class Database {
  static Future<String> buscarDadosGet(
      String endpoint, Map<String, String> parametros) async {
    var url =
        Uri.http(':8070', endpoint, parametros); // adicionar IP da máquina
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

  static Future<String> buscarDadosPost(
      String endpoint, Map<String, String> parametros) async {
    var url = Uri.http(':8070', endpoint); // adicionar IP da máquina
    try {
      var resposta = await http.post(url, body: parametros);

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
}
