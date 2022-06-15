import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/constant/loder.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/orderdetail/screen/order_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<OrderModel>? order;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    fetchOrder();
    super.initState();
  }

  void fetchOrder() async {
    await accountServices.fetchmyOrders(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return order == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        "Yours Order",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )),
                  Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        "See all",
                        style: TextStyle(
                            fontSize: 18,
                            color: GlobalVariables.selectedNavBarColor,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(top: 20, right: 0, left: 10),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: order!.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrderDetailScreen.routeName,
                              arguments: order![index]);
                        },
                        child: SingleProduct(
                            image: order![index].products[0].images[0]),
                      );
                    })),
              )
            ],
          );
  }
}
