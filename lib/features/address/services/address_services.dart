import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveuserAddress(
      {required BuildContext context, required String address}) async {
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({"address": address}),
      );
      httpErrorHandling(
        response: res,
        context: context,
        callback: () {
          User user = userprovider.user
              .copyWith(address: jsonDecode(res.body)["address"]);
          userprovider.setuserFrommodel(user);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void placedorder(
      {required BuildContext context,
      required String address,
      required double totalsum}) async {
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          "address": address,
          "cart": userprovider.user.cart,
          "totalprice": totalsum
        }),
      );
      httpErrorHandling(
        response: res,
        context: context,
        callback: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Your order has been placed")));
          User user = userprovider.user.copyWith(
            cart: [],
          );
          userprovider.setuserFrommodel(user);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
