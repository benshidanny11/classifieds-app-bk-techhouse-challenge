import 'package:classfiedapp/utils/theme_util.dart';
import 'package:classfiedapp/widgets/details_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Product.dart';

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
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 242, 242),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              DetailsHeader(
                product: product,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: screenWidth * 0.9,
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
                height: screnHeight * 0.55,
                decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: ThemeUtil().customTextStyle(
                          const Color(0xFF010035), 24, FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
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
                      'Manufactured on ${dateFormat.format(product.manufacturingDate)}',
                      style: ThemeUtil().customTextStyle(
                          const Color(0xFF010035), 18, FontWeight.w300),
                    ),
                    Text(
                      product.category,
                      style: ThemeUtil().customTextStyle(
                          const Color(0xFF010035), 18, FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${product.price.toString()} RWF',
                      style: ThemeUtil().customTextStyle(
                          Theme.of(context).primaryColor, 18, FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
