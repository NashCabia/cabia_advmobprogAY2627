import 'dart:convert';

import 'package:cabia_mobile/models/cart.dart';
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

    return rawCarts
        .whereType<Map>()
        .map((cart) => Cart.fromJson(Map<String, dynamic>.from(cart)))
        .toList();
  }
}
