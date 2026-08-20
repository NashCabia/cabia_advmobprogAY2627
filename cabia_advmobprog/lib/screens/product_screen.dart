import 'package:flutter/material.dart';
import 'package:cabia_mobile/models/product.dart';
import 'package:cabia_mobile/widgets/custom_text.dart';

// Enhancement 2: detailed screen shown when a product card is selected.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                product.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 220,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.water_drop_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              text: product.title,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: '\$${product.price.toStringAsFixed(2)}',
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 12),
            CustomText(text: product.description, fontSize: 16),
          ],
        ),
      ),
    );
  }
}
