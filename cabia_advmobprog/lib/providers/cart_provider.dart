import 'package:flutter/foundation.dart';
import 'package:cabia_mobile/models/cart.dart';
import 'package:cabia_mobile/models/product.dart';

class CartModel extends ChangeNotifier {
  final Map<int, CartProduct> _items = {};
  bool _initialCartLoaded = false;

  List<CartProduct> get items => _items.values.toList(growable: false);

  int get itemCount =>
      _items.values.fold(0, (total, product) => total + product.quantity);

  double get total => _items.values.fold(
    0,
    (sum, product) => sum + product.price * product.quantity,
  );

  bool get initialCartLoaded => _initialCartLoaded;

  void loadItems(Iterable<CartProduct> products) {
    if (_initialCartLoaded) {
      return;
    }
    for (final product in products) {
      _items[product.id] = product;
    }
    _initialCartLoaded = true;
    notifyListeners();
  }

  void addProduct(Product product) {
    _initialCartLoaded = true;
    final existing = _items[product.id];
    if (existing == null) {
      _items[product.id] = CartProduct(
        id: product.id,
        title: product.title,
        price: product.price,
        quantity: 1,
        total: product.price,
        discountPercentage: 0,
        discountedPrice: product.price,
        thumbnail: product.imageUrl,
      );
    } else {
      _setQuantity(product.id, existing.quantity + 1);
    }
    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final product = _items[productId];
    if (product != null) {
      _setQuantity(productId, product.quantity + 1);
      notifyListeners();
    }
  }

  void decreaseQuantity(int productId) {
    final product = _items[productId];
    if (product == null) {
      return;
    }

    if (product.quantity == 1) {
      _items.remove(productId);
    } else {
      _setQuantity(productId, product.quantity - 1);
    }
    notifyListeners();
  }

  void removeProduct(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void _setQuantity(int productId, int quantity) {
    final product = _items[productId];
    if (product == null) {
      return;
    }

    _items[productId] = product.copyWith(
      quantity: quantity,
      total: product.price * quantity,
      discountedPrice: product.price,
    );
  }
}
