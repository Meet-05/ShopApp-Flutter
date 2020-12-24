import 'package:flutter/material.dart';
import '../provider/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/user_products_widget.dart';
import 'package:ShopApp/widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static final String routeName = '/userProductsScren';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: productData.getProducts.length,
          itemBuilder: (_, index) => UserProductsWidget(
            title: productData.getProducts[index].title,
            imageUrl: productData.getProducts[index].imageUrl,
            id: productData.getProducts[index].id,
          ),
        ),
      ),
    );
  }
}
