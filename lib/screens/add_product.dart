// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'dart:io';
import 'package:classfiedapp/models/Product.dart';
import 'package:classfiedapp/utils/data_utils.dart';
import 'package:classfiedapp/utils/firebase_util.dart';
import 'package:classfiedapp/utils/image_util.dart';
import 'package:classfiedapp/utils/size_utils.dart';
import 'package:classfiedapp/utils/toast_util.dart';
import 'package:classfiedapp/widgets/DropdownWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/theme_util.dart';
import '../widgets/InputWidget.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'Home.dart';

class ProductForm extends StatefulWidget {
  static String id = '/productform';
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _manufacturingDateController = TextEditingController();
  bool loadingAddProduct = false;
  String selectedCategory = getCategories().first;
  DateTime? manufactureDate;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add product',
          style: ThemeUtil().appBarTitleStyle(),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getScreenHeight(context) * .78,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InputWidget(
                                  controller: _nameController,
                                  hint: "Product name",
                                  label: "Enter product name"),
                              const SizedBox(
                                height: 10,
                              ),
                              InputWidget(
                                  controller: _descriptionController,
                                  hint: "Product description",
                                  label: "Enter product description"),
                              const SizedBox(
                                height: 10,
                              ),
                              InputWidget(
                                  controller: _priceController,
                                  hint: "Product price",
                                  label: "Enter product price"),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownWidget(
                                items: getCategories(),
                                selectedValue: selectedCategory,
                                onDropDownChange: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputWidget(
                                controller: _manufacturingDateController,
                                hint: "Product manufacture date",
                                label: "Enter manufacure date",
                                isDatePicker: true,
                                // isEnabled: false,
                                onDatePickerClick: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    manufactureDate = pickedDate;
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    setState(() {
                                      _manufacturingDateController.text =
                                          formattedDate;
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  image == null
                                      ? Image.asset(
                                          'assets/images/iconproduct.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.fitWidth,
                                        )
                                      : Image.file(
                                          File(
                                            image!.path,
                                          ),
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.fitWidth,
                                        ),
                                  IconButton(
                                      onPressed: (() async {
                                        image = await ImageUtil.picImage();
                                        setState(() {
                                          //update UI
                                        });
                                      }),
                                      icon: Icon(Icons.add_a_photo,
                                          color:
                                              Theme.of(context).primaryColor))
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ThemeUtil().buttonStyle(),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            40, 10, 40, 10),
                                        child: loadingAddProduct
                                            ? const CircularProgressIndicator(
                                                color: Colors.white)
                                            : Text(
                                                "Add product".toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            setState(() {
                                              loadingAddProduct = true;
                                            });
                                            var snapshot = await FirebaseUtil()
                                                .getStorageInstance()
                                                .putFile(File(image!.path));
                                            var productImage = await snapshot
                                                .ref
                                                .getDownloadURL();
                                            Product product = Product(
                                              productId:const Uuid().v4(),
                                                name: _nameController.text,
                                                image: productImage,
                                                category: selectedCategory,
                                                description:
                                                    _descriptionController.text,
                                                ownerId: 'Benshidanny',
                                                price: double.parse(
                                                    _priceController.text),
                                                manufacturingDate:
                                                    manufactureDate!);

                                            await FirebaseUtil()
                                                .getProductsCollectionReference()
                                                .add(product.toJson());
                                            // ToastUtil.showSuccessToast(
                                            //     "Product is added successfully");
                                            setState(() {
                                              loadingAddProduct = false;
                                            });
                                            Navigator.pushNamed(
                                                context, Home.id);
                                          } catch (e) {
                                            setState(() {
                                              loadingAddProduct = false;
                                            });
                                            // ToastUtil.showErrorToast(
                                            //     "Product is added successfully");
                                            print(e);
                                          }
                                        }
                                      },
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
