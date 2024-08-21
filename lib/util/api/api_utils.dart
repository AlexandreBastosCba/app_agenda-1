
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
class ApiUtils {
  static const String _port = '3000';
  static const String? _urlProduction = null;
  static const String _baseUrl = _urlProduction ?? 'http://localhost:$_port/api';
  static const String _emuladorUrl = _urlProduction ?? 'http://10.0.2.2:$_port/api';

  static Future<String> get baseUrl async {
    if (kIsWeb) {
      // Se estiver rodando na web
      return _baseUrl;
    } else {
      final deviceInfo = DeviceInfoPlugin();
      if (defaultTargetPlatform == TargetPlatform.android) {
        var androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.isPhysicalDevice) {
          // Dispositivo Android físico
          return _baseUrl;
        } else {
          // Emulador Android
          return _emuladorUrl;
        }
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        var iosInfo = await deviceInfo.iosInfo;
        if (iosInfo.isPhysicalDevice) {
          // Dispositivo iOS físico
          return _baseUrl;
        } else {
          // Emulador iOS
          return _emuladorUrl;
        }
      } else {
        // Fallback para outros ambientes
        return _baseUrl;
      }
    }
  }
}
