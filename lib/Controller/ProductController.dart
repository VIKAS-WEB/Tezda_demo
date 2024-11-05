import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tezda_task/Model/Product.dart';
import 'dart:convert';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var favoriteProducts = <Product>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        products.value = data.map((json) => Product.fromJson(json)).toList();
        hasError(false);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  // Toggle favorite status
  void toggleFavorite(Product product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
  }

  bool isFavorite(Product product) {
    return favoriteProducts.contains(product);
  }
}
