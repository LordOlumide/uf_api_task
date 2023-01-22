abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupLoadedState extends SignupState {}

class SignupErrorState extends SignupState {
  final String errorMessage;

  SignupErrorState(this.errorMessage);
}
