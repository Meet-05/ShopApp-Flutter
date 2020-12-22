import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../provider/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

enum Filteroptions {
  Favorites,
  ShowAll,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Product Overview'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (Filteroptions option) {
                setState(() {
                  if (option == Filteroptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Favorites'),
                      value: Filteroptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('All'),
                      value: Filteroptions.ShowAll,
                    )
                  ]),
          //only the number changes hence we use consumer,the child i.e icon will build only once  while hte value will change.
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
              value: cart.itemsCount.toString(),
            ),
          )
        ],
      ),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}
