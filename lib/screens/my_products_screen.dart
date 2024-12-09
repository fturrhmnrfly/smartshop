import 'package:flutter/material.dart';

class MyProductsScreen extends StatelessWidget {
  // Contoh data produk sementara (nantinya bisa diganti dengan data dari backend atau provider)
  final List<Map<String, String>> products = [
    {'name': 'Produk A', 'price': 'Rp 50.000', 'description': 'Deskripsi Produk A'},
    {'name': 'Produk B', 'price': 'Rp 75.000', 'description': 'Deskripsi Produk B'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk Saya'),
      ),
      body: products.isEmpty
          ? Center(child: Text('Belum ada produk yang ditambahkan'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product['name']!), // Nama produk
                  subtitle: Text(product['price']!), // Harga produk
                  trailing: Icon(Icons.edit), // Tombol untuk edit produk
                  onTap: () {
                    // TODO: Navigasi ke halaman edit produk
                  },
                );
              },
            ),
    );
  }
}
