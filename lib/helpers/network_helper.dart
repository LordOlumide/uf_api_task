import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/token.dart';
import '../exceptions/network_request_exception.dart';
import '../services/hive_services.dart';

class NetworkHelper {
  const NetworkHelper._();

  // /User is to create the user
  // /generateToken is for logging in the user
  // /Authorized is to verify the user is authorized

  static Future<void> testHive({
    required String username,
    required String password,
  }) async {
    HiveService.store(
      boxName: 'Signup credentials',
      data: {'username': username, 'password': password},
    );

    await Future.delayed(const Duration(seconds: 4));

    HiveService.getData(
      boxName: 'Signup credentials',
      keys: ['username', 'password'],
    );
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
