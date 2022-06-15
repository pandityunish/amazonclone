import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/features/admin/screens/analytics_page.dart';
import 'package:amazon_clone/features/admin/screens/order_screen.dart';
import 'package:amazon_clone/features/admin/screens/post_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int page = 0;
  double bottombarwidth = 42;
  double bottombarborderwidth = 5;
  void updatepage(int page2) {
    setState(() {
      page = page2;
    });
  }

  List<Widget> pages = [
    const PostScreen(),
    const AnalyticsPage(),
    const OrderScreen()
  ];
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Admin",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            ],
          ),
        ),
      ),
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
                    child: const Icon(Icons.analytics)),
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
                    child: const Icon(Icons.all_inbox_outlined)),
                label: ""),
          ]),
    );
  }
}
