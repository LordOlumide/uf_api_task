import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/user.dart';
import '../exceptions/network_request_exception.dart';

class NetworkHelper {
  const NetworkHelper._();

  static Future<User> signup({
    required String username,
    required String password,
  }) async {
    final Dio dio = Dio();

    try {
      final response = await dio.post(
        'https://bookstore.toolsqa.com/Account/v1/User',
        data: {"userName": username, "password": password},
      );
      Map<String, dynamic> responseBody = response.data;
      print(responseBody);

      if (response.statusCode == 201) {
        print('Success');
        return User.fromJson(responseBody);
      } else {
        throw Exception('Error occurred');
      }
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
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
