
import 'package:mobile_alga_crm/helpers/api_client.dart';

abstract class AccountRepository{
  final ApiClient api;
  
  AccountRepository({
    required this.api
  });

  Future<String> authGetToken(String username, String password) async {

     final response =  await api.post('auth/login', {
      'username': username,
      'password': password
     });
    return response['token'];
  }

}

