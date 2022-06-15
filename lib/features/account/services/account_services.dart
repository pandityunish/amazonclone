import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/features/auths/screens/auth_screens.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/globle_variable.dart';

class AccountServices {
  Future<List<OrderModel>> fetchmyOrders({
    required BuildContext context,
  }) async {
    List<OrderModel> orderlist = [];
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse("$uri/api/orders/me"),
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

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("x-auth-token", "").whenComplete(() => {
            Navigator.pushNamedAndRemoveUntil(
                context, AuthScreen.routename, (route) => false)
          });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
