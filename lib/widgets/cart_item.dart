import 'package:flutter/material.dart';
import '../provider/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final double price;
  final String title;
  final int quantity;
  final String productId;
  final String id;
  CartItem(
      {@required this.price,
      @required this.title,
      @required this.id,
      @required this.quantity,
      @required this.productId});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.all(10.0),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to remove this item from cart'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('NO')),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Yes')),
                  ],
                ));
      },
      onDismissed: (direction) {
        cart.deleteCartItem(productId);
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: FittedBox(child: Text('$price'))),
            ),
            title: Text('$title'),
            subtitle: Text('${quantity * price}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
