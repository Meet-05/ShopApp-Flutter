import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {@required this.title,
      @required this.id,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  //a map of key as the Product id and value as a cart object
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items == null ? 0 : _items.length;
  }

  void addItem(
      {@required String productId,
      @required String title,
      @required double price}) {
    //if a product already exists in the cart then just increment the quantity else new carttiem
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              title: existingCartItem.title,
              id: existingCartItem.id,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                title: title,
                id: DateTime.now().toString(),
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  double get cartSum {
    double total = 0.0;
    _items.forEach((productId, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void deleteCartItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
