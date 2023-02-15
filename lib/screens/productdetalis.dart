
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';


class ProductDatails extends StatefulWidget {
  static String id = '/productdetails';
  const ProductDatails({Key? key}) : super(key: key);

  @override
  State<ProductDatails> createState() => _ProductDatailsState();
}

class _ProductDatailsState extends State<ProductDatails> {
  var _cartSize = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screnHeight = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:const [
                    // GestureDetector(
                    //   onTap: (() => Navigator.pop(context)),
                    //   child: Container(
                    //     height: 37,
                    //     width: 37,
                    //     decoration: BoxDecoration(
                    //         color: Color(0xFF010035),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: const Icon(
                    //       FontAwesomeIcons.arrowLeft,
                    //       color: Colors.white,
                    //       size: 15,
                    //     ),
                    //   ),
                    // ),
                     Text(
                      'Product details',
                      style: TextStyle(
                          color: Color(0xFF010035),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Container(
              //   width: screenWidth * 0.9,
              //   decoration: BoxDecoration(
              //       color: Color(0xFFFFFFFF),
              //       borderRadius: BorderRadius.circular(12)),
              //   padding: EdgeInsets.all(15),
              //   child: Image.network(
              //     product.image,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   width: screenWidth,
              //   height: screnHeight * 0.55,
              //   decoration: const BoxDecoration(
              //       color: Color(0xFFFFFFFF),
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(20),
              //           topRight: Radius.circular(20))),
              //   padding: const EdgeInsets.all(10),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         product.title,
              //         style: const TextStyle(
              //             color: Color(0xFF010035),
              //             fontSize: 24,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       const SizedBox(
              //         height: 5,
              //       ),
              //     ],
              //   ),
              // )
            
            ],
          ),
        )),
      ),
    );
  }
}
