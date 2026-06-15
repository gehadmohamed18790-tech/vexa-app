 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywalletapp/features/home/cubit/favorites_states.dart';
import 'package:mywalletapp/features/home/data/models/product_model.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final List<ProductModel> _favoriteList = [];

  void getFavorites() {
    emit(FavoritesLoading());
    emit(FavoritesSuccess(List.from(_favoriteList)));
  }

  void toggleFavorite(ProductModel product) {
    if (_favoriteList.any((item) => item.id == product.id)) {
      _favoriteList.removeWhere((item) => item.id == product.id);
    } else {
      _favoriteList.add(product);
    }
    emit(FavoritesSuccess(List.from(_favoriteList)));
  }

  bool isFavorite(int productId) {
    return _favoriteList.any((item) => item.id == productId);
  }
}