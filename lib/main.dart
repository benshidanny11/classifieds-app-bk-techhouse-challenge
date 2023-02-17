import 'package:classfiedapp/screens/home.dart';
import 'package:classfiedapp/screens/add_product.dart';
import 'package:classfiedapp/screens/my_products.dart';
import 'package:classfiedapp/screens/product_details.dart';
import 'package:classfiedapp/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classifieds App',
      theme: ThemeData(
        primaryColor: const Color(0xFFEB612A),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Welcome(),
      routes: {
        Home.id: (context) => const Home(),
        ProductForm.id: (context) => const ProductForm(),
        Welcome.id: (context) => const Welcome(),
        ProductDatails.id: (context) => const ProductDatails(),
        MyProducts.id: (context) => const MyProducts()
      },
    );
  }
}
