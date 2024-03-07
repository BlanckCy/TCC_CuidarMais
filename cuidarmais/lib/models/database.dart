import 'package:http/http.dart' as http;
import 'dart:convert';

class Database {
  static Future<List<dynamic>> buscarDadosGet(
      String endpoint, Map<String, String> parametros) async {
    var url = Uri.http(':8070', endpoint, parametros); // adicionar IP da máquina
    try {
      var resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        return json.decode(resposta.body);
      } else {
        throw Exception(
            'Falha ao buscar dados. Código de status: ${resposta.statusCode}');
      }
    } catch (e) {
      // Se ocorrer algum erro durante a solicitação, imprimir o erro no console e retornar uma lista vazia
      print('Erro ao buscar dados: $e');
      return [];
    }
  }

  static Future<List<dynamic>> buscarDadosPost(
      String endpoint, Map<String, String> parametros) async {
    var url = Uri.http(':8070', endpoint, parametros); // adicionar IP da máquina
    try {
      var resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        return json.decode(resposta.body);
      } else {
        throw Exception(
            'Falha ao buscar dados. Código de status: ${resposta.statusCode}');
      }
    } catch (e) {
      // Se ocorrer algum erro durante a solicitação, imprimir o erro no console e retornar uma lista vazia
      print('Erro ao buscar dados: $e');
      return [];
    }
  }
}
