// lib/models/cart_item.dart
import 'product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;

  CartItem({
    required this.id, // Parameter 'id' wajib.
    required this.product,
    required this.quantity, // Parameter 'quantity' wajib.
  });
}
