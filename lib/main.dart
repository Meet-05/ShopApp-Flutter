import 'package:flutter/material.dart';
import 'screens/products_overview_screen.dart';
import './screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import './provider/products_provider.dart';
import './screens/product_detail.dart';
import './provider/cart.dart';
import './screens/cart_screen.dart';
import './provider/order.dart';
import './screens/orders_screen.dart';
import 'screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductsProvider>(
            create: (context) => ProductsProvider(),
          ),
          ChangeNotifierProvider<Cart>(create: (context) => Cart()),
          ChangeNotifierProvider<Orders>(create: (context) => Orders()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: ProductOverviewScreen(),
            routes: {
              ProductDetail.routeName: (context) => ProductDetail(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen()
            }));
  }
}
