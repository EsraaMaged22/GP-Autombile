import 'package:bloc/bloc.dart';
import '../models/user_model.dart';
import '../states/signUpState.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  void saveStep1(UserModel user) {
    emit(SignupStep1Completed(user));
  }

  void completeSignup(UserModel user) {
    emit(SignupCompleted(user));
  }
}