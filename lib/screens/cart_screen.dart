// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';
import 'order_list_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.items.length,
            itemBuilder: (context, index) {
              var cartItem = cartProvider.items[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: Image.network(cartItem.product.imageUrl, fit: BoxFit.cover),
                  ),
                  title: Text(cartItem.product.name),
                  subtitle: Text('Rp ${cartItem.product.price.toStringAsFixed(0)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      cartProvider.removeFromCart(cartItem.product);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total:'),
                    Text(
                      'Rp ${cartProvider.totalAmount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: cartProvider.items.isEmpty ? null : () {
                    _processCheckout(context, cartProvider);
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _processCheckout(BuildContext context, CartProvider cartProvider) {
    // Ambil OrderProvider
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    // Buat objek Order baru
    final newOrder = Order(
      id: DateTime.now().toString(), // Generate unique ID
      items: cartProvider.items,
      totalAmount: cartProvider.totalAmount,
      dateTime: DateTime.now(),
    );

    // Tambahkan order ke OrderProvider
    orderProvider.addOrder(newOrder);

    // Hapus semua item dari keranjang
    cartProvider.clearCart();

    // Tampilkan dialog sukses
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Checkout Berhasil'),
        content: Text('Pesanan Anda telah dibuat.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // Tutup dialog
              Navigator.of(ctx).pop();
              
              // Navigasi ke layar daftar pesanan
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderListScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}