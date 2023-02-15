import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUtil {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

   CollectionReference getProductsCollectionReference() {
  return _firestore.collection('products');
}

Reference getStorageInstance() {
  return _firebaseStorage.ref().child("productimages");
}
}
