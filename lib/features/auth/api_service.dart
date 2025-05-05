import 'package:autombile/features/auth/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://ef92-197-43-93-58.ngrok-free.app/api"));

  // Login method
  Future<Response> login({required String emailOrId, required String password}) async {
    try {
      Response response = await _dio.post(
        '/login',
        queryParameters: {
          "email_or_national_id": emailOrId,
          "password": password,
        },
      );
      return response;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  // Sign-up method
  Future<Response> register1(UserModel user, String password) async {
    try {
      Response response = await _dio.post(
        "/register1",
        queryParameters: {
          "fullName": user.fullName,
          "email": user.email,
          "phoneNumber": user.phoneNumber,
          "nationalId": user.nationalId,

        },

      );
      return response;
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  Future<Response> register2(UserModel user, String password) async {
    try {
      Response response = await _dio.post(
        "/register2",
        queryParameters: {
          "address": user.address,
          "licenseNumber": user.licenseNumber,
          "numberOfCars": user.numberOfCars,
          "carDashboard": user.carDashboard,
          "password": password,

        },

      );
      return response;
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }



  Future<Response> generateOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/generate-otp',
        queryParameters: {
          'email': email,
          'otp': otp,
        },
      );
      return response;
    } catch (e) {
      throw Exception("OTP verification failed: $e");
    }
  }

  Future<Response> forgotPassword({required String email}) async {
    try {
      final response = await _dio.post(
        '/send-otp',
        queryParameters: {
          'email': email,
        },
      );
      return response;
    } catch (e) {
      throw Exception("Forgot password failed: $e");
    }
  }


}
