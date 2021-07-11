import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tyba_test_daniel/src/providers/preferences_provider.dart';
import 'package:tyba_test_daniel/src/config/endpoints.dart';


class UserRepository {
  final _prefs = PreferencesProvider();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returSecureToken': true
    };

    final resp = await http.post(
        '$fireBaseAuth/accounts:signInWithPassword?key=$fireBaseApiKey',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'message': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returSecureToken': true
    };

    final resp = await http.post(
        '$fireBaseAuth/accounts:signUp?key=$fireBaseApiKey',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'message': decodedResp['error']['message']};
    }
  }

  void logout (){
    _prefs.token = null;
  }
}
