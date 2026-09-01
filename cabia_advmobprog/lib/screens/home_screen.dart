import 'package:flutter/material.dart';
import 'package:cabia_mobile/constants.dart';
import 'package:cabia_mobile/models/product.dart';
import 'package:cabia_mobile/screens/cart_screen.dart';
import 'package:cabia_mobile/screens/product_screen.dart';
import 'package:cabia_mobile/services/product_service.dart';
import 'package:cabia_mobile/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  int _selectedDestination = 0;

  Future<List<Product>> _getProducts() {
    final query = _query.trim();
    if (query.isEmpty) {
      return ProductService.fetchProducts();
    }
    return ProductService.searchProducts(query);
  }

  Future<void> _selectDestination(int index) async {
    setState(() {
      _selectedDestination = index;
    });

    if (index == 1) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartScreen()),
      );
    } else if (index == 2) {
      await Navigator.pushNamed(context, '/settings');
    } else if (index == 3) {
      await Navigator.pushNamed(context, '/profile');
    }

    if (mounted) {
      setState(() {
        _selectedDestination = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AppConstants.appTitle,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: CustomText(text: 'Failed to load products'));
          }

          final products = snapshot.data ?? const [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: AppConstants.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _query = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: products.isEmpty
                    ? const Center(child: CustomText(text: 'No products found'))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: SizedBox(
                                width: 56,
                                height: 56,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Icon(
                                      Icons.water_drop_outlined,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                              title: CustomText(
                                text: product.title,
                                fontWeight: FontWeight.w600,
                              ),
                              subtitle: CustomText(
                                text: product.description,
                                maxLines: 2,
                              ),
                              trailing: CustomText(
                                text: '\$${product.price.toStringAsFixed(2)}',
                              ),
                              // Enhancement 2: tapping a card opens the detailed product screen.
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailScreen(product: product),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedDestination,
        onDestinationSelected: _selectDestination,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Catalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune),
            label: 'Theme',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
