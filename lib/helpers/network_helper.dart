import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/token.dart';
import '../exceptions/network_request_exception.dart';

class NetworkHelper {
  const NetworkHelper._();

  // /User is to create the user
  // /generateToken is for logging in the user
  // /Authorized is to verify the user is authorized

  static Future<void> testHive({
    required String username,
    required String password,
  }) async {
    var signUpBox = await Hive.openBox('Signup credentials');
    signUpBox.putAll({'username': username, 'password': password});
    print('Storing::: username: $username and password: $password.');

    await Future.delayed(const Duration(seconds: 4));

    String retrievedUsername = signUpBox.get('username');
    String retrievedPassword = signUpBox.get('password');
    print(
        'Retrieving::: username: $retrievedUsername and password: $retrievedPassword.');
  }

  static final Dio dio = Dio();

  static Future<User> signup({
    required String username,
    required String password,
  }) async {
    testHive(username: username, password: password);

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
