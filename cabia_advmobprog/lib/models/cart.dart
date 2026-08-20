class CartProduct {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedPrice;
  final String thumbnail;

  const CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
  });

  // Enhancement 1: parse DummyJSON cart products with safe defaults.
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: _asInt(json['id']),
      title: _asString(json['title']),
      price: _asDouble(json['price']),
      quantity: _asInt(json['quantity']),
      total: _asDouble(json['total']),
      discountPercentage: _asDouble(json['discountPercentage']),
      discountedPrice: _asDouble(json['discountedPrice']),
      thumbnail: _asString(json['thumbnail']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'quantity': quantity,
    'total': total,
    'discountPercentage': discountPercentage,
    'discountedPrice': discountedPrice,
    'thumbnail': thumbnail,
  };

  static int _asInt(Object? value) => value is num ? value.toInt() : 0;

  static double _asDouble(Object? value) =>
      value is num ? value.toDouble() : 0.0;

  static String _asString(Object? value) => value is String ? value : '';
}

class Cart {
  final int id;
  final List<CartProduct> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  const Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final rawProducts = json['products'];
    final products = rawProducts is List
        ? rawProducts
              .whereType<Map>()
              .map(
                (product) =>
                    CartProduct.fromJson(Map<String, dynamic>.from(product)),
              )
              .toList()
        : <CartProduct>[];

    return Cart(
      id: CartProduct._asInt(json['id']),
      products: products,
      total: CartProduct._asDouble(json['total']),
      discountedTotal: CartProduct._asDouble(json['discountedTotal']),
      userId: CartProduct._asInt(json['userId']),
      totalProducts: CartProduct._asInt(json['totalProducts']),
      totalQuantity: CartProduct._asInt(json['totalQuantity']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'products': products.map((product) => product.toJson()).toList(),
    'total': total,
    'discountedTotal': discountedTotal,
    'userId': userId,
    'totalProducts': totalProducts,
    'totalQuantity': totalQuantity,
  };
}
