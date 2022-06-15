import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/features/account/screens/account_page.dart';
import 'package:amazon_clone/features/cart/screens/cart_screens.dart';
import 'package:amazon_clone/features/home/screens/homescreen.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottombar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int page = 0;
  double bottombarwidth = 42;
  double bottombarborderwidth = 5;
  void updatepage(int page2) {
    setState(() {
      page = page2;
    });
  }

  List<Widget> pages = [
    const Homescreen(),
    const Accountpage(),
    const CartScreens()
  ];
  @override
  Widget build(BuildContext context) {
    final usercartlen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: page,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 28,
          onTap: updatepage,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  width: bottombarwidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: bottombarborderwidth,
                              color: page == 0
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor))),
                  child: const Icon(Icons.home_outlined),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Container(
                    width: bottombarwidth,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: bottombarborderwidth,
                                color: page == 1
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.backgroundColor))),
                    child: const Icon(Icons.person_outline_outlined)),
                label: ""),
            BottomNavigationBarItem(
                icon: Container(
                    width: bottombarwidth,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: bottombarborderwidth,
                                color: page == 2
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.backgroundColor))),
                    child: Badge(
                      elevation: 0,
                      badgeContent: Text(usercartlen.toString()),
                      badgeColor: Colors.white,
                      child: const Icon(Icons.shopping_cart_outlined),
                    )),
                label: "")
          ]),
    );
  }
}
