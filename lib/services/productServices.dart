import 'package:classfiedapp/models/Product.dart';
import 'package:classfiedapp/utils/firebase_util.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    try {
      List<Product> products = [];
      final productDocs =
          await FirebaseUtil().getProductsCollectionReference().get();
      for (var doc in productDocs.docs) {
        products.add(Product.fromJSon(doc.data()));
      }
      print("=================================>Hello");
      return products;
    } catch (e) {
       print("=================================>Errorrr");
      return [];
      
    }
  }
}
