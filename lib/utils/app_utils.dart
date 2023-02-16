import 'dart:io';

import 'package:classfiedapp/services/AuthService.dart';
import 'package:classfiedapp/utils/firebase_util.dart';

import '../models/Product.dart';

import 'package:uuid/uuid.dart';

class AppUtil {
  static Future<void> addProduct(
      {required String name,
      required String category,
      required String description,
      required double price,
      required DateTime manufacturingDate,required
      String imgFilePath}) async {
    var snapshot =
        await FirebaseUtil().getStorageInstance().putFile(File(imgFilePath));
    var productImage = await snapshot.ref.getDownloadURL();
    Product product = Product(
        productId: const Uuid().v4(),
        name: name,
        image: productImage,
        category: category,
        description: description,
        ownerId: AuthService.getCurrentUser()!.uid,
        price: price,
        manufacturingDate: manufacturingDate);
    await FirebaseUtil().getProductsCollectionReference().add(product.toJson());
  }
}
