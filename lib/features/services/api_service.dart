
import 'dart:io';
import 'package:autombile/features/auth/models/user_model.dart';
import 'package:dio/dio.dart';
class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://e439-197-32-24-7.ngrok-free.app/api"));

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
        '/send-otp',
        data: {
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

  Future<Response> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        '/reset-password',
        queryParameters: {
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      return response;
    } catch (e) {
      throw Exception("Reset password failed: $e");
    }
  }
  Future<Response> uploadEvidence({
    required int emergencyId,
    required String category,
    required String filePath,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'emergency_id': emergencyId,
        'category': category,
        'evidence': await MultipartFile.fromFile(filePath, filename: filePath.split('/').last),
      });

      final response = await _dio.post(
        '/upload-evidence',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      return response;
    } catch (e) {
      throw Exception("Upload Evidence failed: $e");
    }
  }
  Future<Response> toggleDrivingMode({required bool isEnabled}) async {
    try {
      final response = await _dio.post(
        '/driving-mode/toggle',
        data: {"is_driving_mode": isEnabled}, // as JSON body
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception("Toggling driving mode failed: $e");
    }
  }
  Future<Response> updateUserProfile({
    required UserModel user,
    required String jobTitle,
    File? licenseFile,
  }) async {
    try {


      Map<String, dynamic> data = {
        'full_name': user.fullName,
        'phone': user.phoneNumber,
        'job_title': jobTitle,
        'address': user.address,
        'national_id': user.nationalId,
        'vehicle_model': user.carDashboard,
      };

      FormData formData;

      // Only add driving_license if file is provided
      if (licenseFile != null && licenseFile.existsSync()) {
        data['driving_license'] = await MultipartFile.fromFile(
          licenseFile.path,
          filename: licenseFile.path.split('/').last,
        );
        formData = FormData.fromMap(data);
      } else {
        // Send without file - two options based on what your backend expects:

        // Option 1: Don't include driving_license field at all
        formData = FormData.fromMap(data);

        // Option 2: Include empty driving_license field (uncomment if backend requires it)
        // data['driving_license'] = null;
        // formData = FormData.fromMap(data);

        // Option 3: Send as regular JSON without multipart (uncomment if backend supports it)
        // final response = await _dio.post(
        //   '/profile',
        //   data: data, // Send as JSON instead of FormData
        //   options: Options(
        //     headers: {
        //       'Authorization': 'Bearer $_authToken',
        //       'Accept': 'application/json',
        //       'Content-Type': 'application/json',
        //     },
        //   ),
        // );
        // return response;
      }

      final response = await _dio.post(
        '/profile',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Session expired. Please login again.");
      } else if (e.response?.statusCode == 422) {
        // Validation error
        final errors = e.response?.data['errors'] ?? {};
        final message = e.response?.data['message'] ?? 'Validation failed';
        String errorMessage = '$message: ';
        if (errors is Map) {
          errors.forEach((key, value) {
            if (value is List) {
              errorMessage += '${value.join(', ')} ';
            }
          });
        }
        throw Exception(errorMessage);
      }
      throw Exception("Profile update failed: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      throw Exception("Profile update failed: $e");
    }
  }
  }

