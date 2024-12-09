import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import 'order_screen.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';
import '../providers/cart_provider.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  color: const Color(0xFF204889),
                  child: const Center(
                    child: Icon(Icons.image, size: 50),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Tambah ke Keranjang
                  Provider.of<CartProvider>(context, listen: false).addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Produk ditambahkan ke keranjang')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green, // Warna berbeda untuk pembeda
                ),
                child: const Text('Tambah ke Keranjang'),
              ),
            ),
            const SizedBox(width: 10), // Spasi antar tombol
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                final order = Order(
                  id: DateTime.now().toString(),
                  items: [
                    CartItem(
                      id: DateTime.now().toString(),
                      product: product,
                      quantity: 1,
                    ),
                  ],
                  totalAmount: product.price,
                  dateTime: DateTime.now(),
                );

                Provider.of<OrderProvider>(context, listen: false).addOrder(order);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderScreen(product: product),
                  ),
                );
              },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Beli Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}