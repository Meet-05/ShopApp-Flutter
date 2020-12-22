import 'package:flutter/material.dart';
import 'package:ShopApp/provider/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as widget;
import '../provider/order.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/CartScreen';
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyCart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$ ${cart.cartSum}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color,
                          fontSize: 15.0,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false)
                            .addOrder(cart.items.values.toList(), cart.cartSum);
                        cart.clearCart();
                      },
                      child: Text('Order Now'),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) => widget.CartItem(
                productId: cart.items.keys.toList()[index],
                title: cart.items.values.toList()[index].title,
                id: cart.items.values.toList()[index].id,
                quantity: cart.items.values.toList()[index].quantity,
                price: cart.items.values.toList()[index].price),
          ))
        ],
      ),
    );
  }
}
