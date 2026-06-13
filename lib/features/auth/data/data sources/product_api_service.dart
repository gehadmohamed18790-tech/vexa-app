import 'package:dio/dio.dart';
import 'package:mywalletapp/features/home/data/models/product_model.dart';



class ProductApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1'));

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('فشل في تحميل المنتجات');
      }
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }
}