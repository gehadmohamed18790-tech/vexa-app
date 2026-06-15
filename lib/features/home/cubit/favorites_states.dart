import 'package:mywalletapp/features/home/data/models/product_model.dart';



abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {
  final List<ProductModel> favoriteProducts;
  FavoritesSuccess(this.favoriteProducts);
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}