// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount => _calculateTotal();

  void addToCart(Product product) {
    // Cek apakah produk sudah ada di keranjang
    var existingItemIndex = _items.indexWhere((item) => item.product.id == product.id);

    if (existingItemIndex >= 0) {
      // Jika sudah ada, tambahkan kuantitas
      var existingItem = _items[existingItemIndex];
      _items[existingItemIndex] = CartItem(
        id: existingItem.id, // ID tetap sama
        product: existingItem.product,
        quantity: existingItem.quantity + 1, // Tambahkan kuantitas
      );
    } else {
      // Jika belum ada, tambahkan item baru dengan ID unik
      _items.add(CartItem(
        id: DateTime.now().toString(), // Generate ID unik
        product: product,
        quantity: 1, // Kuantitas awal
      ));
    }
    
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double _calculateTotal() {
    return _items.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }
}
