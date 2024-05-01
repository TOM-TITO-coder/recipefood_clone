// ignore_for_file: avoid_print

import 'package:recipfood/models/user.dart';
import 'package:recipfood/services/http_service.dart';

class AuthService {

  static final AuthService _singleton = AuthService._internal();

  final _httpService = HTTPService();

  User? user;

  factory AuthService(){
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService.post("auth/login", {
        "username": username,
        "password": password,
      });      
      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        HTTPService().setup(bearerToken: user!.token);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}