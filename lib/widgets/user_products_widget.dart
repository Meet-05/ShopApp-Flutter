import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';

class UserProductsWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  UserProductsWidget({this.imageUrl, this.title, this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName,
                    arguments: id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
