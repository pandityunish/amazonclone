import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart " as http;

void httpErrorHandling(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback callback}) {
  switch (response.statusCode) {
    case 200:
      callback();
      break;
    case 400:
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)["mes"])));
      break;
    case 500:
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)["error"])));
      break;
    default:
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(jsonDecode(response.body))));
  }
}
