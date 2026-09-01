import 'dart:convert';

import 'package:cabia_mobile/models/cart.dart';
import 'package:cabia_mobile/services/product_service.dart';
import 'package:http/http.dart' as http;

class CartService {
  static const _baseUrl = 'https://dummyjson.com';

  static Future<List<Cart>> fetchUserCarts(int userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/carts/user/$userId'));

    if (response.statusCode != 200) {
      throw Exception('Unable to load carts (${response.statusCode})');
    }

    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      return const [];
    }

    final rawCarts = body['carts'];
    if (rawCarts is! List) {
      return const [];
    }

    final carts = rawCarts
        .whereType<Map>()
        .map((cart) => Cart.fromJson(Map<String, dynamic>.from(cart)))
        .toList();

    // Keep DummyJSON quantities while using the app's catalog details.
    final catalog = await ProductService.fetchProducts();
    final productsById = {for (final product in catalog) product.id: product};

    return carts.map((cart) {
      final products = cart.products.asMap().entries.map((entry) {
        final cartProduct = entry.value;
        final catalogProduct =
            productsById[cartProduct.id] ?? catalog[entry.key % catalog.length];

        return cartProduct.copyWith(
          title: catalogProduct.title,
          price: catalogProduct.price,
          total: catalogProduct.price * cartProduct.quantity,
          discountedPrice: catalogProduct.price,
          thumbnail: catalogProduct.imageUrl,
        );
      }).toList();

      final total = products.fold<double>(
        0,
        (sum, product) => sum + product.price * product.quantity,
      );

      return Cart(
        id: cart.id,
        products: products,
        total: total,
        discountedTotal: total,
        userId: cart.userId,
        totalProducts: products.length,
        totalQuantity: products.fold<int>(
          0,
          (sum, product) => sum + product.quantity,
        ),
      );
    }).toList();
  }
}
