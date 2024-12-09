import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/order_provider.dart';

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesanan Saya')),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          // Cek apakah tidak ada pesanan
          if (orderProvider.orders.isEmpty) {
            return Center(
              child: Text(
                'Belum ada pesanan',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Tampilkan daftar pesanan
          return ListView.builder(
            itemCount: orderProvider.orders.length,
            itemBuilder: (context, index) {
              final order = orderProvider.orders[index];
              final dateFormatter = DateFormat('dd MMM yyyy, HH:mm');
              final formattedDate = dateFormatter.format(order.dateTime);
              final currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

              return Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pesanan #${order.id}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Tanggal: $formattedDate'),
                      SizedBox(height: 8),
                      Text(
                        'Total: ${currencyFormatter.format(order.totalAmount)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Daftar item dalam pesanan
                      order.items.isNotEmpty
                          ? Column(
                              children: order.items.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      // Hapus operator null-aware, langsung akses imageUrl
                                      Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.grey[200],
                                      child: Image.network(
                                        item.product.imageUrl, 
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(Icons.broken_image);
                                        },
                                      )
                                    ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.name,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              currencyFormatter.format(item.product.price),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          : Text('Tidak ada item dalam pesanan.'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
