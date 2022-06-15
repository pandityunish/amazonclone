import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String catogery}) async {
    List<Product> productslist = [];
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("$uri/api/product?category=$catogery"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
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

  Future<Product> fetchdealofday({
    required BuildContext context,
  }) async {
    Product products = Product(
        name: "",
        description: "",
        quantity: 0,
        images: [],
        category: "",
        price: 0);
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("$uri/api/deal-of-day"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
      );
      httpErrorHandling(
          response: res,
          context: context,
          callback: () {
            products = Product.fromJson(res.body);
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return products;
  }
}
