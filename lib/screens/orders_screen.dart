import 'package:flutter/material.dart';
import '../provider/order.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as widget;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static final String routeName = '/OrdersScreen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) => widget.OrderItem(
                order: orderData.orders[index],
              )),
      drawer: AppDrawer(),
    );
  }
}
