import 'package:amazon_clone/constant/loder.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/orderdetail/screen/order_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel>? order;
  final AdminService adminService = AdminService();
  @override
  void initState() {
    fetchallorder();
    super.initState();
  }

  void fetchallorder() async {
    order = await adminService.fetchallorder(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return order == null
        ? const Loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: order!.length,
            itemBuilder: (context, index) {
              final orderdata = order![index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,
                      arguments: orderdata);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderdata.products[0].images[0]),
                ),
              );
            },
          );
  }
}
