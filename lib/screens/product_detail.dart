import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class ProductDetail extends StatelessWidget {
  static String routeName = '/ProductDetail';

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    print(loadedProduct);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.id),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              loadedProduct.imageUrl,
              width: double.infinity,
              height: 250.0,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '\$ ${loadedProduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 30.0),
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: Text(
                  '${loadedProduct.description}',
                  softWrap: true,
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
