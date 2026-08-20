import 'package:flutter/material.dart';
import 'package:cabia_mobile/models/cart.dart';
import 'package:cabia_mobile/models/product.dart';
import 'package:cabia_mobile/screens/product_screen.dart';
import 'package:cabia_mobile/services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.userId = 1});

  final int userId;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<Cart>> _cartsFuture;

  @override
  void initState() {
    super.initState();
    _cartsFuture = CartService.fetchUserCarts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Aquarium Cart')),
      body: FutureBuilder<List<Cart>>(
        future: _cartsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load your cart: ${snapshot.error}'),
            );
          }

          final carts = snapshot.data ?? const <Cart>[];
          final products = carts.expand((cart) => cart.products).toList();
          if (products.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final total = products.fold<double>(
            0,
            (sum, product) => sum + product.discountedPrice * product.quantity,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) =>
                      _CartProductTile(product: products[index]),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Total  \$${total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      // Enhancement 3: confirm the complete cart in one action.
                      FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order confirmed')),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Confirm Order'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CartProductTile extends StatelessWidget {
  const _CartProductTile({required this.product});

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: SizedBox(
          width: 64,
          height: 64,
          child: Image.network(
            product.thumbnail,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const Icon(Icons.water_drop_outlined),
          ),
        ),
        title: Text(product.title),
        subtitle: Text(
          'Qty ${product.quantity}  |  \$${product.price.toStringAsFixed(2)} each',
        ),
        trailing: Text(
          '\$${(product.discountedPrice * product.quantity).toStringAsFixed(2)}',
        ),
        // Enhancement 2: cart products open the shared product detail screen.
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(
                product: Product(
                  id: product.id,
                  title: product.title,
                  description: 'Aquarium product from your cart.',
                  imageUrl: product.thumbnail,
                  price: product.discountedPrice,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
