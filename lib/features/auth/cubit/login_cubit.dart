import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../services/api_service.dart';


class LoginCubit extends Cubit<bool> {
  final ApiService _apiService;

  LoginCubit(this._apiService) : super(false);

  Future<void> login(String emailOrId, String password) async {
    emit(true); // Loading state
    try {
      Response response = await _apiService.login(
        emailOrId: emailOrId,
        password: password,
      );

      if (response.statusCode == 200) {
        // Handle success
        emit(false);
        return; // Or handle navigation in the UI
      } else {
        throw Exception(response.data["message"] ?? "Login failed!");
      }
    } catch (e) {
      emit(false);
      rethrow; // Catch the error in the UI
    }
  }
}