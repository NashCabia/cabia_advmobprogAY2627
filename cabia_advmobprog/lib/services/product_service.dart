import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cabia_mobile/models/product.dart';

class ProductService {
  static const _baseUrl = 'https://dummyjson.com';

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products?limit=30'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> products = jsonData['products'] ?? [];

        return products.map((product) {
          return Product(
            id: product['id'] ?? 0,
            title: product['title'] ?? 'Unknown Product',
            description: product['description'] ?? 'No description available',
            imageUrl: product['thumbnail'] ?? product['images']?[0] ?? '',
            price: (product['price'] ?? 0).toDouble(),
          );
        }).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products/search?q=$query'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> products = jsonData['products'] ?? [];

        return products.map((product) {
          return Product(
            id: product['id'] ?? 0,
            title: product['title'] ?? 'Unknown Product',
            description: product['description'] ?? 'No description available',
            imageUrl: product['thumbnail'] ?? product['images']?[0] ?? '',
            price: (product['price'] ?? 0).toDouble(),
          );
        }).toList();
      } else {
        throw Exception('Failed to search products');
      }
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}
