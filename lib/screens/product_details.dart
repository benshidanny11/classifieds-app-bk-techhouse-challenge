import 'package:classfiedapp/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Product.dart';
import '../utils/share_util.dart';

class ProductDatails extends StatefulWidget {
  static String id = '/productdetails';
  const ProductDatails({Key? key}) : super(key: key);

  @override
  State<ProductDatails> createState() => _ProductDatailsState();
}

class _ProductDatailsState extends State<ProductDatails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screnHeight = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Product product = args['product'];
    final dateFormat = DateFormat('dd-MM-yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product details',
          style: ThemeUtil().appBarTitleStyle(),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                shareProduct(product);
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 250, 242, 242),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(15),
              child: Image.network(
                product.image,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: screenWidth,
              // height: screnHeight * 0.55,
              decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 24, FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    'Product decription:',
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 16, FontWeight.w700),
                  ),
                  Text(
                    product.description,
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 18, FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Product category:',
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 16, FontWeight.w700),
                  ),
                  Text(
                    product.category,
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 16, FontWeight.w300),
                  ),
                   const SizedBox(
                    height: 5,
                  ),
                    Text(
                    'Manufactured on:',
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 16, FontWeight.w700),
                  ),
                  Text(
                    dateFormat.format(product.manufacturingDate),
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 16, FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                    Text(
                    'Product price:',
                    style: ThemeUtil().customTextStyle(
                        const Color(0xFF010035), 16, FontWeight.w700),
                  ),
                  Text(
                    '${product.price.toString()} RWF',
                    style: ThemeUtil().customTextStyle(
                        Theme.of(context).primaryColor, 16, FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
