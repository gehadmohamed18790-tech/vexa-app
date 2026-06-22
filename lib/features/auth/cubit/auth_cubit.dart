import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mywalletapp/core/storage/cach_helper.dart';
import '../data/data sources/auth_api_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthApiService _apiService;

  AuthCubit(this._apiService) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await _apiService.login(email, password);

      await CacheHelper.saveData(key: "user", value: user.token);
      print("user.token ${user.token}");
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
