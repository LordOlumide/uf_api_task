import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './login_state.dart';
import '../../exceptions/network_request_exception.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider() {
    _currentState = LoginInitialState();
  }

  late LoginState _currentState;
  LoginState get currentState => _currentState;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    _emit(LoginLoadingState());

    final Dio dio = Dio();
    try {
      final Response response = await dio.post(
        'https://bookstore.demoqa.com/Account/v1/GenerateToken',
        data: {"userName": username, "password": password},
      );
      Map<String, dynamic> responseBody = response.data;
      print('responseBody: $responseBody');
      print('responseCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        _emit(LoginLoadedState());
      } else {
        _emit(LoginErrorState('An Error occurred'));
      }
    }
    // on DioError catch (e) {
    //   if (e.response != null) {
    //     print(NetworkRequestException(
    //       message: '${e.response!.data['message']}',
    //       code: double.parse(e.response!.data['code']).toInt(),
    //     ));
    //     throw NetworkRequestException(
    //       message: '${e.response!.data['message']}',
    //       code: double.parse(e.response!.data['code']).toInt(),
    //     );
    //   }
    //   _emit(LoginErrorState('An Error occurred'));
    //   rethrow;
    // }
    catch (e) {
      _emit(LoginErrorState('An Error occurred'));
      print('Catching Error ::: ${e.toString}');
      rethrow;
    }
  }

  void _emit(LoginState newState) {
    _currentState = newState;
    print('changing state to $newState');
    notifyListeners();
  }

  @override
  void dispose() {
    _currentState = LoginInitialState();
    super.dispose();
  }
}
