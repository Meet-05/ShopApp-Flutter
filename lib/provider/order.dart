import 'package:flutter/foundation.dart';
import './cart.dart';

class Orderitem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Orderitem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<Orderitem> _orders = [];

  List<Orderitem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double totol) {
    _orders.insert(
        0,
        Orderitem(
            id: DateTime.now().toString(),
            amount: totol,
            products: products,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
