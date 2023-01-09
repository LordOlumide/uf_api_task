import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/token.dart';
import '../exceptions/network_request_exception.dart';

class NetworkHelper {
  const NetworkHelper._();

  // /User is to create the user
  // /generateToken is for logging in the user
  // /Authorized is to verify the user is authorized

  static final Dio dio = Dio();

  static Future<User> signup({
    required String username,
    required String password,
  }) async {
    try {
      final Response response = await dio.post(
        'https://bookstore.demoqa.com/Account/v1/User',
        data: {"userName": username, "password": password},
      );
      Map<String, dynamic> responseBody = response.data;

      if (response.statusCode == 201) {
        print('Success');
        return User.fromJson(responseBody);
      } else {
        throw Exception('Error occurred');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw NetworkRequestException(
          message: '${e.response!.data['message']}',
          code: double.parse(e.response!.data['code']).toInt(),
        );
      }
      rethrow;
    } catch (e) {
      print('Catching ERROR ::: ' + e.toString());
      rethrow;
    }
  }
}
