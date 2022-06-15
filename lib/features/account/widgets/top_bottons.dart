import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class Topbottom extends StatefulWidget {
  const Topbottom({Key? key}) : super(key: key);

  @override
  State<Topbottom> createState() => _TopbottomState();
}

class _TopbottomState extends State<Topbottom> {
  final AccountServices accountServices = AccountServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Accountbutton(text: "Your Order", onpressed: () {}),
            Accountbutton(text: "Turn Seller", onpressed: () {})
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Accountbutton(
                text: "Log Out",
                onpressed: () {
                  accountServices.logOut(context);
                }),
            Accountbutton(text: "Your Wish List", onpressed: () {})
          ],
        ),
      ],
    );
  }
}
