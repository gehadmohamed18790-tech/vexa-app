import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthApiService {
  final Dio _dio = Dio();

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://api.platzi.com/api/v1/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final String receivedToken = response.data['access_token'] ?? '';

        return UserModel(
          id: 0, 
          name: 'Logged In User', 
          email: email, 
          token: receivedToken,
        );
      } else {
        throw Exception("فشل تسجيل الدخول، تأكد من البيانات");
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? "حدث خطأ ما، حاول مجدداً";
      throw Exception(errorMessage);
    }
  }
}