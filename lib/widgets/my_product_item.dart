import 'package:classfiedapp/models/Product.dart';
import 'package:classfiedapp/services/productServices.dart';
import 'package:classfiedapp/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../screens/product_details.dart';
import '../utils/theme_util.dart';

class MyProductItem extends StatefulWidget {
  Product product;
  Function refreshOnDelere;
  MyProductItem(
      {super.key, required this.product, required this.refreshOnDelere});

  @override
  State<MyProductItem> createState() => _MyProductItemState();
}

class _MyProductItemState extends State<MyProductItem> {
  bool loadingOnDelete = false;
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, ProductDatails.id,
            arguments: {'product': widget.product});
      }),
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      widget.product.image,
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: ThemeUtil().customTextStyle(
                            const Color.fromRGBO(1, 0, 53, 1),
                            16,
                            FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.product.price.toString(),
                          style: ThemeUtil().customTextStyle(
                            const Color.fromRGBO(1, 0, 53, 1),
                            13,
                            FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          dateFormat.format(widget.product.manufacturingDate),
                          style: ThemeUtil().customTextStyle(
                            const Color.fromRGBO(1, 0, 53, 1),
                            13,
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      showCustomAlertDialog(context, "Delete product",
                          "Are you sure you want to delete this product?",
                          onNegativeButtonClick: () {},
                          onPostiveButtonClick: () async {
                        setState(() {
                          loadingOnDelete = true;
                        });
                        await ProductService.deleteProduct(
                            widget.product.productId);
                        setState(() {
                          loadingOnDelete = false;
                        });
                        widget.refreshOnDelere();
                      });
                    },
                    icon: loadingOnDelete
                        ? SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                              
                            ),
                        )
                        : Icon(
                            Icons.delete,
                            color: Theme.of(context).primaryColor,
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
