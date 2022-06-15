import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/features/admin/model/admin.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminService {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dsqtxanz6", "l9djmh0i");
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: product.toJson(),
      );
      httpErrorHandling(
        response: res,
        context: context,
        callback: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added sucessfully")));
          Navigator.pop(context);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //get all products
  Future<List<Product>> getallproducts(BuildContext context) async {
    List<Product> productslist = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandling(
          response: res,
          context: context,
          callback: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productslist
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return productslist;
  }

  //delete product
  void deletepoduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onsucess}) async {
    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/delete-product"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({"id": product.id}));

      httpErrorHandling(
          response: res,
          context: context,
          callback: () {
            onsucess();
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<List<OrderModel>> fetchallorder(BuildContext context) async {
    List<OrderModel> orderlist = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/order/me"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandling(
          response: res,
          context: context,
          callback: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderlist.add(
                  OrderModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return orderlist;
  }

  void changorderStatus(
      {required BuildContext context,
      required int status,
      required OrderModel orderModel,
      required VoidCallback onsucess}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/admin/change-order"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"id": orderModel.id, "status": status}));

      httpErrorHandling(
          response: res,
          context: context,
          callback: () {
            onsucess();
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<Map<String, dynamic>> getEarning(BuildContext context) async {
    List<Sales> sales = [];
    int totalEaring = 0;
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/analytics"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandling(
          response: res,
          context: context,
          callback: () {
            var response = jsonDecode(res.body);
            totalEaring = response["totalEarning"];
            sales = [
              Sales("Mobiles", response["mobileEarnings"]),
              Sales("Essentials", response["essentialsEarnings"]),
              Sales("Appliances", response["appliancesEarnings"]),
              Sales("Books", response["books"]),
              Sales("Fashion", response["fashionEarnings"]),
            ];
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return {"sales": sales, "totalEaring": totalEaring};
  }
}
