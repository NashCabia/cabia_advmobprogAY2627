import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cabia_mobile/models/cart.dart';
import 'package:cabia_mobile/models/product.dart';
import 'package:cabia_mobile/providers/cart_provider.dart';
import 'package:cabia_mobile/screens/product_screen.dart';
import 'package:cabia_mobile/services/cart_service.dart';
import 'package:cabia_mobile/services/user_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.userId});

  final int? userId;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final Future<void> _initialCart;

  @override
  void initState() {
    super.initState();
    _initialCart = _loadInitialCart();
  }

  Future<void> _loadInitialCart() async {
    final cart = context.read<CartModel>();
    if (cart.initialCartLoaded) return;

    final user = await UserService.getUser();
    final resolvedUserId = user?.id ?? widget.userId;
    if (resolvedUserId == null) {
      cart.loadItems(const []);
      return;
    }

    final carts = await CartService.fetchUserCarts(resolvedUserId);
    cart.loadItems(carts.expand((item) => item.products));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: FutureBuilder<void>(
        future: _initialCart,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load your cart: ${snapshot.error}'),
            );
          }

          return Consumer<CartModel>(
            builder: (context, cart, _) {
              if (cart.items.isEmpty) {
                return const Center(
                  child: Text('Your cart is empty. Add a fish to get started.'),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) =>
                          _CartProductTile(product: cart.items[index]),
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
                              'Total  \$${cart.total.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          // Enhancement 3: confirm the complete cart in one action.
                          FilledButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Order confirmed'),
                                ),
                              );
                              cart.clear();
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
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Decrease quantity',
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    context.read<CartModel>().decreaseQuantity(product.id);
                  },
                ),
                Text('${product.quantity}'),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Increase quantity',
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    context.read<CartModel>().increaseQuantity(product.id);
                  },
                ),
              ],
            ),
          ],
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
                  description: 'Product from your cart.',
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
