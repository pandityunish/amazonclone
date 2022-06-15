import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Belowappbar extends StatelessWidget {
  const Belowappbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: RichText(
        text: TextSpan(
            text: "Hello, ",
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: userprovider.user.name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              )
            ]),
      ),
    );
  }
}
