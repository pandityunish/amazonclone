import 'dart:io';

import 'package:amazon_clone/common/widgets/costum_buttom.dart';
import 'package:amazon_clone/common/widgets/costum_textfield.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/constant/utiles.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productnamecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();
  final AdminService service = AdminService();
  @override
  void dispose() {
    pricecontroller.dispose();
    productnamecontroller.dispose();
    descriptioncontroller.dispose();
    quantitycontroller.dispose();
    super.dispose();
  }

  List<File> images = [];
  String categoty = "Mobiles";
  List<String> porductCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];
  final addproductFormkey = GlobalKey<FormState>();
  void selectImages() async {
    var res = await pickimage();
    setState(() {
      images = res;
    });
  }

  void sellproduct() {
    if (addproductFormkey.currentState!.validate() && images.isNotEmpty) {
      service.sellProduct(
          context: context,
          name: productnamecontroller.text,
          description: descriptioncontroller.text,
          price: double.parse(pricecontroller.text),
          quantity: double.parse(quantitycontroller.text),
          category: categoty,
          images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: addproductFormkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                  builder: ((BuildContext context) =>
                                      Image.file(
                                        i,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      )));
                            }).toList(),
                            options: CarouselOptions(
                                viewportFraction: 1, height: 200))
                        : GestureDetector(
                            onTap: () {
                              selectImages();
                            },
                            child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Select Product Images",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CostumFormfield(
                        controller: productnamecontroller,
                        hinttext: "Product Name"),
                    const SizedBox(
                      height: 10,
                    ),
                    CostumFormfield(
                        maxline: 7,
                        controller: descriptioncontroller,
                        hinttext: "Description"),
                    const SizedBox(
                      height: 10,
                    ),
                    CostumFormfield(
                        controller: pricecontroller, hinttext: "Price"),
                    const SizedBox(
                      height: 10,
                    ),
                    CostumFormfield(
                        controller: quantitycontroller, hinttext: "Quantity"),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                          items: porductCategories.map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                          value: categoty,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onChanged: (String? newval) {
                            setState(() {
                              categoty = newval!;
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Costumbottom(
                        text: "Sell",
                        onPressed: () {
                          sellproduct();
                        })
                  ],
                ),
              ))),
    );
  }
}
