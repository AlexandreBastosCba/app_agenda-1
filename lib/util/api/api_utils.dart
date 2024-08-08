class ApiUtils {
  static const String baseUrl = "http://localhost:3000/api";

  static const _scheme = 'http';
  static const _host = 'localhost';
  static const _port = 3000;
  static const _pathLogin = 'api/Auth/Login';

  static Uri createLoginUri(String cpf) {
    return Uri(
      scheme: _scheme,
      host: _host,
      port: _port,
      path: _pathLogin,
      queryParameters: {
        'cpf': cpf,
      },
    );
  }
}
