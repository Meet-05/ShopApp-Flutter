import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorites;
  ProductGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    final loadedProducts =
        showFavorites ? products.getFavoriteProducts : products.getProducts;

    return GridView.builder(
      itemCount: loadedProducts.length,
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
