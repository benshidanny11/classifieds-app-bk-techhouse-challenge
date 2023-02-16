import 'package:classfiedapp/models/Product.dart';
import 'package:classfiedapp/utils/firebase_util.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    try {
      List<Product> products = [];
      final productDocs =
          await FirebaseUtil().getProductsCollectionReference().limit(10).get();
      for (var doc in productDocs.docs) {
        products.add(Product.fromJSon(doc.data()));
      }
      sortProducts(products);
      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }

  void sortProducts(List<Product> products) {
    products.sort(((product1, product2) {
      return product1.name.toLowerCase().compareTo(product2.name.toLowerCase());
    }));
  }
}
