import 'package:classfiedapp/services/AuthService.dart';
import 'package:classfiedapp/services/productServices.dart';
import 'package:classfiedapp/widgets/fab_items.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/Product.dart';
import '../utils/theme_util.dart';
import '../widgets/product_item.dart';

class Home extends StatefulWidget {
  static String id = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Future? _future;
  ProductService? _service;
  Animation<double>? _animation;
  AnimationController? _animationController;
  @override
  void initState() {
    _service = ProductService();
    _future = _service!.getProducts();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController as Animation<double>);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 250, 242, 242),
      appBar: AppBar(
        title: Text(
          'Classfied app',
          style: ThemeUtil().appBarTitleStyle(),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
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
                  : StaggeredGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      axisDirection: AxisDirection.down,
                      children: products
                          .map((product) => ProductItem(
                                product: product,
                              ))
                          .toList());
            },
          ),
        ),
      ),
      floatingActionButton: AuthService.getCurrentUser() != null
          ? FloatingActionBubble(
              items: getFabItems(_animationController, context),
              animation: _animation as Animation,
              onPress: () => _animationController!.isCompleted
                  ? _animationController!.reverse()
                  : _animationController!.forward(),
              iconColor: Colors.white,
              iconData: Icons.add,
              backGroundColor: Theme.of(context).primaryColor,
            )
          : null,
    );
  }
}
