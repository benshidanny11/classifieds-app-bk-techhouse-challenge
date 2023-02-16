import 'package:classfiedapp/utils/share_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/Product.dart';

class DetailsHeader extends StatelessWidget {
  Product product;
  DetailsHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (() => Navigator.pop(context)),
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Text(
            'Product details',
            style: TextStyle(
                color: Color(0xFF010035),
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: (() {
              shareProduct(product);
            }),
            child: Icon(
              Icons.share,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
