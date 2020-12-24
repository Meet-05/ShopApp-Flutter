import 'package:flutter/material.dart';
import '../provider/products_provider.dart';
import '../provider/product.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static final String routeName = '/EditProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //creating a focus node to direct user to enter fields using '->' without killing keyboard again and again
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  var _imageUrlController = TextEditingController();
  var _form = GlobalKey<
      FormState>(); //track the form state and allow us to react to change
  var _editableProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: ' ',
  );
  var _isInit = true;
  var _initValues = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  final imageUrlController = TextEditingController();

  void _saveForm() {
    if (_form.currentState.validate()) {
      //runs every validator in form and returns true if all validators are succesfull
      _form.currentState.save(); //saves the current state of form
      if (_editableProduct.id != null) {
        Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_editableProduct.id, _editableProduct);
      } else {
        Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editableProduct);
      }
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editableProduct);
      Navigator.pop(context);
    }
  }

  @override
  //dispose the focuseNodes to realloacte memeory consumed by them
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      _editableProduct =
          Provider.of<ProductsProvider>(context).findById(productId);
      if (_editableProduct != null) {
        _initValues = {
          'title': _editableProduct.title,
          'description': _editableProduct.description,
          'id': _editableProduct.id,
          'price': _editableProduct.price.toString(),
          'imageUrl': _editableProduct.imageUrl
        };
        imageUrlController.text = _initValues['imageUrl'];
      }
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('edit product'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  _saveForm();
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  //to do when the next button tapped on softkeyBoard
                  onFieldSubmitted: (_) {
                    //after hitting submit button on keyboard got to?
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Title should not be empty';
                    }
                    //input accepted
                    return null;
                  },
                  onSaved: (value) {
                    _editableProduct = Product(
                        id: _editableProduct.id,
                        title: value,
                        description: _editableProduct.description,
                        price: _editableProduct.price,
                        imageUrl: _editableProduct.imageUrl,
                        isFavorite: _editableProduct.isFavorite);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) => {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode)
                  },
                  validator: (price) {
                    if (price.isEmpty) {
                      return 'Price should not be empty';
                    }
                    if (double.tryParse(price) == null) {
                      return 'price should be a number ';
                    }
                    //input accepted
                    return null;
                  },
                  //onSaved called when _form.save() method
                  onSaved: (value) {
                    _editableProduct = Product(
                        id: _editableProduct.id,
                        isFavorite: _editableProduct.isFavorite,
                        title: _editableProduct.title,
                        description: _editableProduct.description,
                        price: double.parse(value),
                        imageUrl: _editableProduct.imageUrl);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _editableProduct = Product(
                        id: _editableProduct.id,
                        isFavorite: _editableProduct.isFavorite,
                        title: _editableProduct.title,
                        description: value,
                        price: _editableProduct.price,
                        imageUrl: _editableProduct.imageUrl);
                  },
                  validator: (description) {
                    if (description.isEmpty) {
                      return 'Description should not be empty';
                    }
                    if (description.length < 10) {
                      return 'description should be more than 10 characters';
                    }
                    //input accepted
                    return null;
                  },
                ),
                Row(
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 5),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text('?')
                            : FittedBox(
                                child:
                                    Image.network(_imageUrlController.text))),
                    Expanded(
                      child: TextFormField(
                        controller: imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'ImageUrl',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onSaved: (value) {
                          _editableProduct = Product(
                              id: _editableProduct.id,
                              title: _editableProduct.title,
                              isFavorite: _editableProduct.isFavorite,
                              description: _editableProduct.description,
                              price: _editableProduct.price,
                              imageUrl: value);
                        },
                        validator: (url) {
                          if (url.isEmpty) {
                            return 'URL should not be empty';
                          }
                          if (!url.startsWith('http') &&
                              !url.startsWith('https')) {
                            return 'invalid url';
                          }
                          if (!url.endsWith('.jpg') &&
                              !url.endsWith('.png') &&
                              !url.endsWith('.jpeg')) {
                            return 'invalid url';
                          }
                          //input accepted
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          setState(() {});
                          _saveForm();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
