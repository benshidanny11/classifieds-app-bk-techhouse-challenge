import 'package:classfiedapp/services/productServices.dart';
import 'package:classfiedapp/widgets/my_product_item.dart';
import 'package:flutter/material.dart';

import '../models/Product.dart';
import '../utils/theme_util.dart';

class MyProducts extends StatefulWidget {
  static String id = '/myproducts';
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductState();
}

class _MyProductState extends State<MyProducts> {
  Future? _future;
  ProductService? _service;
  @override
  void initState() {
    _service = ProductService();
    _future = _service!.getMyProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 242, 242),
      appBar: AppBar(
        title: Text(
          'My products',
          style: ThemeUtil().appBarTitleStyle(),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<dynamic>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            List<Product> products = snapshot.data;

            return products.isEmpty
                ? const Center(child: Text('No data found'))
                : SizedBox(
                  height: screenHeight * 0.8,
                  child: ListView.builder(itemBuilder: ((context, index) {
                      return MyProductItem(product: products[index], refreshOnDelere: (){
                        setState(() {
                          _future = _service!.getMyProducts();
                        });
                      },);
                    }),
                    itemCount: products.length,
                    ),
                );
          },
        ),
      ),
    );
  }
}
