// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'dart:io';
import 'package:classfiedapp/models/Product.dart';
import 'package:classfiedapp/utils/app_utils.dart';
import 'package:classfiedapp/utils/data_utils.dart';
import 'package:classfiedapp/utils/firebase_util.dart';
import 'package:classfiedapp/utils/image_util.dart';
import 'package:classfiedapp/utils/size_utils.dart';
import 'package:classfiedapp/utils/toast_util.dart';
import 'package:classfiedapp/widgets/button_text_widget.dart';
import 'package:classfiedapp/widgets/date_picker_input.dart';
import 'package:classfiedapp/widgets/dropdown_widget.dart';
import 'package:classfiedapp/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/theme_util.dart';
import '../widgets/input_widget.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'home.dart';

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
  void initState() {
    _manufacturingDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    manufactureDate = DateTime.now();
    super.initState();
  }

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
      backgroundColor: const Color.fromARGB(255, 250, 242, 242),
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
                                label: "Enter product price",
                                isNumber: true,
                              ),
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
                              DatePickerInput(
                                controller: _manufacturingDateController,
                                hint: "Product manufacture date",
                                label: "Enter manufacure date",
                                // isEnabled: false,
                                onDatePickerClick: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1923),
                                      lastDate: DateTime.now());

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
                              ImagePickerWidget(
                                  image: image,
                                  onTap: () async {
                                    image = await ImageUtil.picImage();
                                    setState(() {});
                                  }),

                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     image == null
                              //         ? Image.asset(
                              //             'assets/images/iconproduct.png',
                              //             width: 60,
                              //             height: 60,
                              //             fit: BoxFit.fitWidth,
                              //           )
                              //         : Image.file(
                              //             File(
                              //               image!.path,
                              //             ),
                              //             width: 60,
                              //             height: 60,
                              //             fit: BoxFit.fitWidth,
                              //           ),
                              //     IconButton(
                              //         onPressed: (() async {
                              //           image = await ImageUtil.picImage();
                              //           setState(() {
                              //           });
                              //         }),
                              //         icon: Icon(Icons.add_a_photo,
                              //             color:
                              //                 Theme.of(context).primaryColor))
                              //   ],
                              // ),

                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ThemeUtil().buttonStyle(),
                                      child: ButtonTextWidget(
                                        label: "Add product",
                                        loading: loadingAddProduct,
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            setState(() {
                                              loadingAddProduct = true;
                                            });
                                            await AppUtil.addProduct(
                                                category: selectedCategory,
                                                name: _nameController.text,
                                                description:
                                                    _descriptionController.text,
                                                manufacturingDate:
                                                    manufactureDate,
                                                imgFilePath: image!.path,
                                                price: double.parse(
                                                    _priceController.text));
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
                                            print("Errorrrr=====>");
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
