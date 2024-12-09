// lib/providers/order_provider.dart
import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/cart_item.dart'; // Impor CartItem

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}