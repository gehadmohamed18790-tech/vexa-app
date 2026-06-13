import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/data_sources/home_api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeApiService _apiService;

  HomeCubit(this._apiService) : super(HomeInitial());

  Future<void> getProducts() async {
    emit(HomeLoading());
    try {
      final products = await _apiService.fetchProducts();
      emit(HomeSuccess(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}