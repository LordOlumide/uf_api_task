import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/user.dart';
import '../exceptions/network_request_exception.dart';

class NetworkHelper {
  const NetworkHelper._();

  static final Dio dio = Dio();

  static Future<User> signup({
    required String username,
    required String password,
  }) async {
    try {
      final Response response = await dio.post(
        'https://bookstore.toolsqa.com/Account/v1/User',
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

  static Future<bool> signin({
    required String username,
    required String password,
  }) async {
    try {
      final Response response = await dio.post(
        'https://bookstore.toolsqa.com/Account/v1/Authorized',
        data: {"userName": username, "password": password},
      );
      bool responseBody = response.data;
      print('responseBody: $responseBody');
      print('responseCode: ${response.statusCode}');
      print('responseMessage: ${response.statusMessage}');

      // TODO: Fix ERROR: I'm getting statusCode 200, but the body is false instead of true

      if (response.statusCode == 200) {
        return responseBody;
      } else {
        throw Exception('An Error occurred');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(NetworkRequestException(
          message: '${e.response!.data['message']}',
          code: double.parse(e.response!.data['code']).toInt(),
        ));
        throw NetworkRequestException(
          message: '${e.response!.data['message']}',
          code: double.parse(e.response!.data['code']).toInt(),
        );
      }
      rethrow;
    } catch (e) {
      print('Catching Error ::: ${e.toString}');
      rethrow;
    }
  }
}
