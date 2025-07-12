import '../models/user_model.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupStep1Completed extends SignupState {
  final UserModel user;

  SignupStep1Completed(this.user);
}

class SignupCompleted extends SignupState {
  final UserModel user;
  SignupCompleted(this.user);
}