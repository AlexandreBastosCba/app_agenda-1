import 'dart:convert';
import 'package:app_agenda/util/api/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:app_agenda/models/users/users.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersServices extends ChangeNotifier {
  static const nameOfCPF = 'cpf';
  static const nameOfBirthday = 'birthday';
  SharedPreferences? prefs;
  Users? currentUsers;

  //Constructor disparando o método loadCurrentUser
  UsersServices() {
    _instanciarDepedenncias().then((_) {
      _loadCurrentUser();
    });
  }

  _instanciarDepedenncias() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> signIn(String cpf, DateTime birthday) async {
    try {
      if (await _verificarNaApiSeHaUsuarioComCrendenciaisInformadas(cpf, birthday)) {
        Users users = Users(cpf: cpf, birthday: birthday);
        _setarUsuarioNoArmanezamentoLocal(users);
        _loadCurrentUser();
        return Future.value(true);
      }
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> _verificarNaApiSeHaUsuarioComCrendenciaisInformadas(
      String cpf, DateTime birthday) async {
    // Formata o CPF para remover caracteres especiais
    String cpfFormatado = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    final uri = Uri.parse('${await ApiUtils.baseUrl}/Auth/Login?cpf=$cpfFormatado');

    // Realiza a solicitação POST
    final response = await http.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: '', // Envia o corpo da solicitação vazio
    );

    // Verifica a resposta
    if (response.statusCode == 200) {
      final responseBody =
          response.body.trim(); // Remove espaços em branco desnecessários
      if (responseBody == '"Autorizado"') {
        return Future.value(true); // Usuário autorizado
      } else if (responseBody == '"Negado"') {
        return Future.value(false); // Usuário não autorizado
      } else {
        debugPrint('Resposta inesperada: $responseBody');
        throw Exception('Erro ao verificar credenciais');
      }
    } else {
      // Trata os erros
      debugPrint('Falha na solicitação: ${response.statusCode}');
      throw Exception('Erro ao verificar credenciais');
    }
  }

  _loadCurrentUser() async {
    Users? users = await _obterUsuarioDoArmazenamentoLocal();

    //Verificar sempre se o usuário do armazenamento local ainda existe na API
    if (users != null) {
      if (await _verificarNaApiSeHaUsuarioComCrendenciaisInformadas(
          users.cpf!, users.birthday!)) {
        currentUsers = users;
        notifyListeners();
      } else {
        signOut();
      }
    }
  }

  Future<Users?> _obterUsuarioDoArmazenamentoLocal() async {
    if (await _verificarSeHaUsuarioNoArmazenamentoLocal()) {
      return Future.value(Users(
          cpf: prefs!.getString(nameOfCPF),
          birthday: DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
              .parse(prefs!.getString(nameOfBirthday) ?? '')));
    }
    return Future.value(null);
  }

  Future<bool> _verificarSeHaUsuarioNoArmazenamentoLocal() async {
    if (prefs!.containsKey(nameOfCPF) &&
        prefs!.getString(nameOfCPF) != null &&
        prefs!.containsKey(nameOfBirthday) &&
        prefs!.getString(nameOfBirthday) != null) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  _setarUsuarioNoArmanezamentoLocal(Users users) async {
    prefs!.setString(nameOfCPF, users.cpf!);
    prefs!.setString(nameOfBirthday, users.birthday!.toString());
  }

  Future<void> signOut() async {
    currentUsers = null;
    prefs!.remove(nameOfCPF);
    prefs!.remove(nameOfBirthday);
    notifyListeners();
  }

  /* --- Validações --- */
  static String? validateCpf(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Por favor, insira um CPF válido.';
    } 
    // else if (!CPFValidator.isValid(cpf)) {
    //   return 'CPF inválido';
    // }
    return null;
  }

  static String? validateBirthday(String? birthday) {
    if (birthday == null || birthday.isEmpty) {
      return 'Por favor, insira sua data de nascimento.';
    } else {
      try {
        DateTime dateTimeBirthday = DateFormat("dd/MM/yyyy").parse(birthday);
        if (dateTimeBirthday.isBefore(DateTime(1900)) ||
            dateTimeBirthday.isAfter(DateTime.now())) {
          return 'Data inválida: insira uma data entre 01/01/1900 e a data atual.';
        }
        return null;
      } on FormatException {
        return 'Insira uma data válida.';
      }
    }
  }
}
