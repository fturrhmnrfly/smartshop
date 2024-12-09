import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/order_list_screen.dart';
import 'my_products_screen.dart';
import 'sell_product_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil data pengguna dari AuthProvider
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.name ?? 'User Name'; // Nama default jika kosong
    final userEmail = authProvider.email ?? 'user@email.com'; // Email default jika kosong

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                SizedBox(height: 16),
                Text(
                  userName, // Tampilkan nama pengguna
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(userEmail), // Tampilkan email pengguna
              ],
            ),
          ),
          SizedBox(height: 32),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Pesanan Saya'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlist'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to wishlist
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Alamat'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to addresses
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Pengaturan'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
          ListTile(
            leading: Icon(Icons.storefront),
            title: Text('Mulai Berjualan'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellProductScreen(), // Navigasi ke halaman "Mulai Berjualan"
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Produk Saya'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProductsScreen(), // Navigasi ke halaman daftar produk
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
