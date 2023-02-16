import 'package:classfiedapp/screens/product_details.dart';
import 'package:classfiedapp/utils/share_util.dart';
import 'package:classfiedapp/utils/theme_util.dart';
import 'package:classfiedapp/widgets/img_loading_indicatior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../models/Product.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final dateFormat = DateFormat('dd-MM-yyyy');
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDatails.id,
            arguments: {'product': product});
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  loadingBuilder: loadingBuilder,
                ),
                //  Positioned(right: 2, top: 2, child: LikeProduct())
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: ThemeUtil().customTextStyle(
                    const Color.fromRGBO(1, 0, 53, 1),
                    16,
                    FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                 Text(
                  dateFormat.format(product.manufacturingDate),
                  style: ThemeUtil().customTextStyle(
                     const Color.fromRGBO(1, 0, 53, 1),
                    13,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.price} RWF',
                  style: ThemeUtil().customTextStyle(
                    Theme.of(context).primaryColor,
                    13,
                    FontWeight.w400,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      shareProduct(product);
                    },
                    icon: Icon(
                      Icons.share,
                      color: Theme.of(context).primaryColor,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
