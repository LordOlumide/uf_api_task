import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './signup_state.dart';
import '../../exceptions/network_request_exception.dart';
import '../../models/user.dart';
import '../../services/hive_services.dart';

class SignupProvider extends ChangeNotifier {
  SignupProvider() {
    _currentState = SignupInitialState();
  }

  late SignupState _currentState;
  SignupState get currentState => _currentState;

  final Dio dio = Dio();

  Future<User> signup({
    required String username,
    required String password,
  }) async {
    _emit(SignupLoadingState());

    HiveService.testHive(username: username, password: password);

    try {
      final Response response = await dio.post(
        'https://bookstore.demoqa.com/Account/v1/User',
        data: {"userName": username, "password": password},
      );
      Map<String, dynamic> responseBody = response.data;

      if (response.statusCode == 201) {
        _emit(SignupLoadedState());
        User user = User.fromJson(responseBody);
        print('Current user = $user');
        return user;
      } else {
        _emit(SignupErrorState('Error occurred'));
        throw Exception('Error occurred');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        _emit(SignupErrorState('${e.response!.data['message']}'));
        throw NetworkRequestException(
          message: '${e.response!.data['message']}',
          code: double.parse(e.response!.data['code']).toInt(),
        );
      }
      rethrow;
    } catch (e) {
      _emit(SignupErrorState(e.toString()));
      print('Catching ERROR ::: ' + e.toString());
      rethrow;
    }
  }

  void _emit(SignupState newState) {
    _currentState = newState;
    print('changing state to $newState');
    notifyListeners();
  }

  @override
  void dispose() {
    _currentState = SignupInitialState();
    super.dispose();
  }
}
