import 'package:classfiedapp/services/productServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Product.dart';
import '../utils/theme_util.dart';
import '../widgets/product_item.dart';

class Home extends StatefulWidget {
  static String id = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future? _future;
  ProductService? _service;
  @override
  void initState() {
    _service = ProductService();
    _future = _service!.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Classfied app',
          style: ThemeUtil().appBarTitleStyle(),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<dynamic>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          List<Product> products = snapshot.data;
          return StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              axisDirection: AxisDirection.down,
              children: products
                  .map((product) => ProductItem(
                        product: product,
                      ))
                  .toList());
        },
      ),
    );
  }
}
