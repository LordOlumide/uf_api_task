abstract class SignupState {}

class LoginInitialState extends SignupState {}

class LoginLoadingState extends SignupState {}

class LoginSuccessState extends SignupState {}

class LoginErrorState extends SignupState {
  final String errorMessage;

  LoginErrorState(this.errorMessage);
}
