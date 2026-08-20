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
  late Future<List<Product>> _productsFuture;
  String _query = '';
  int _selectedDestination = 0;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.fetchProducts();
  }

  List<Product> _filterProducts(List<Product> products) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return products;
    }

    return products.where((product) {
      final titleMatch = product.title.toLowerCase().contains(query);
      final descMatch = product.description.toLowerCase().contains(query);
      return titleMatch || descMatch;
    }).toList();
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
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: CustomText(text: 'Failed to load products'));
          }

          final products = _filterProducts(snapshot.data ?? const []);

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
            icon: Icon(Icons.water_drop_outlined),
            selectedIcon: Icon(Icons.water_drop),
            label: 'Aquarium',
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
        ],
      ),
    );
  }
}
