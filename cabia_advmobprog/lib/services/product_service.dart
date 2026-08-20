import 'package:cabia_mobile/models/product.dart';

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      Product(
        id: 1,
        title: 'Royal Blue Betta',
        description:
            'A vibrant male Betta splendens with flowing royal-blue fins.',
        imageUrl: 'https://loremflickr.com/600/400/betta,fish?lock=1',
        price: 24.99,
      ),
      Product(
        id: 2,
        title: 'Neon Tetra School',
        description:
            'A lively school of peaceful neon tetras for a planted aquarium.',
        imageUrl: 'https://loremflickr.com/600/400/neon,tetra,fish?lock=2',
        price: 32.50,
      ),
      Product(
        id: 3,
        title: 'Fancy Guppy Pair',
        description:
            'A colorful pair of hardy fancy guppies with bright flowing tails.',
        imageUrl: 'https://loremflickr.com/600/400/guppy,fish?lock=3',
        price: 54.99,
      ),
      Product(
        id: 4,
        title: 'Cherry Shrimp Colony',
        description:
            'A bright Neocaridina colony that adds movement and color to planted tanks.',
        imageUrl:
            'https://loremflickr.com/600/400/cherry,shrimp,aquarium?lock=4',
        price: 18.75,
      ),
    ];
  }
}
