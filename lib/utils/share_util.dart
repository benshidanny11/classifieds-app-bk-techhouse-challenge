import 'package:classfiedapp/models/Product.dart';
import 'package:flutter_share/flutter_share.dart';

shareProduct(Product product) async {
  await FlutterShare.share(
      title: product.name,
      text:
          'Product name: ${product.name}\n\n${product.description}\nManufactured on: ${product.manufacturingDate}\nPrice: ${product.price}RWF\nSee the image on the link below',
      linkUrl: product.image,
      chooserTitle: 'See the product image');
}
