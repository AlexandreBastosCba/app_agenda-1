import 'dart:convert';
import 'package:app_agenda/models/contact/contact.dart';
import 'package:app_agenda/util/api/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class ContactService {

  Future<List<Contact>> getContacts() async {
    try {
      final response = await http
          .get(Uri.parse('${ApiUtils.baseUrl}/Contatos/GetListaContatos'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Contact.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar contatos');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao carregar contatos');
    }
  }
}
