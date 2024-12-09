import 'cart_item.dart'; // Impor CartItem dengan benar.

class Order {
  final String id;
  final List<CartItem> items; // Gunakan CartItem sebagai tipe.
  final double totalAmount;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });
}
