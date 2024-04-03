import 'package:flutter/material.dart';
import 'package:mobile_alga_crm/domain/entity/account/account.dart';
import 'package:mobile_alga_crm/helpers/api_client.dart';

class AuthenticationRepository {
  final ApiClient _api;
  String _token;
  AuthenticationRepository(ApiClient api): _api = api,_token='';

  Future<void> setToken(String token) async {
    _token = token;
    _api.setBearerToken(token);
  }

  getToken() {
    return _token;
  }


  Future<Account> getMe() async {
    debugPrint("AuthenticationRepository:getMe()");
    final Map<String,dynamic> response = await _api.post('/auth/me',{}); 
    debugPrint("response: ${response.toString()}");
    if ( !response.containsKey('error')) {
      return Account.fromMap(response['data']);
    } else {
      debugPrint("Message: ${response['message']} \r\n Error: ${response['error']}");
      setToken('');
      
    }
    
    return Account(id: '0');
  }

  Future<String?> signInWithRefreshToken(String refreshToken ) async {
    final Map<String,dynamic> response = await _api.post('/auth/refresh-token', {'refresh_token':refreshToken});
      if (response.containsKey('data')) {
        _token = response['data'];
         _api.setBearerToken(_token);
          return _token;
      }

    return null; 
  }

  Future<Account> logIn(String username, String password) async {

      final Map<String,dynamic> response = await _api.post('/auth/login', {'username':username,'password':password});

      if ( response.containsKey('error') && !response.containsKey('data')) {
        return Account(id: '0');
      }

      if ( !response.containsKey('error') && response.containsKey('data')) {
        //debugPrint(response['data']['token'].toString());
        
        await setToken(response['data']['token'].toString()); 
        return Account.fromMap(response['data']['account']);
      }
      debugPrint("Future<Account> logIn(String username, String password)");
      //debugPrint(response['data'].toString());
   return Account(id: '0');
  }

  Future<void> loginOut() async {
      
  }
  
}
