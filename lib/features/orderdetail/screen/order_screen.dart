import 'package:amazon_clone/common/widgets/costum_buttom.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = "/Order-detail";
  final OrderModel orderModel;
  const OrderDetailScreen({Key? key, required this.orderModel})
      : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentstep = 0;
  final AdminService adminService = AdminService();
  @override
  void initState() {
    currentstep = widget.orderModel.status;
    super.initState();
  }

  void navigatetoSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  //only for admin
  void changeOrderStatus(int stas) async {
    adminService.changorderStatus(
        context: context,
        status: stas,
        orderModel: widget.orderModel,
        onsucess: () {
          setState(() {
            currentstep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigatetoSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 24,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "View order details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Order Date:         ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.orderModel.orderedAt))}"),
                  Text("Order Id:      ${widget.orderModel.id}"),
                  Text("Order Total:   \$${widget.orderModel.totalPrice}")
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Purchase Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.orderModel.products.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.orderModel.products[i].images[0],
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderModel.products[i].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              "Qty:${widget.orderModel.quantity[i].toString()}",
                            ),
                          ],
                        ))
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Tracking",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Stepper(
                    currentStep: currentstep,
                    controlsBuilder: (context, details) {
                      if (user.type == "admin") {
                        return Costumbottom(
                            text: "Done",
                            onPressed: () {
                              changeOrderStatus(details.currentStep);
                            });
                      }
                      return const SizedBox();
                    },
                    steps: [
                      Step(
                          title: const Text("Pending"),
                          isActive: currentstep > 0,
                          state: currentstep > 0
                              ? StepState.complete
                              : StepState.indexed,
                          content:
                              const Text("Your order is yet to be delivered")),
                      Step(
                          title: const Text("Completed"),
                          isActive: currentstep > 1,
                          state: currentstep > 1
                              ? StepState.complete
                              : StepState.indexed,
                          content: const Text(
                              "Your order has be delivered, you are yet to sign.")),
                      Step(
                          title: const Text("Received"),
                          isActive: currentstep > 2,
                          state: currentstep > 2
                              ? StepState.complete
                              : StepState.indexed,
                          content: const Text(
                              "Your order has be delivered and signed by you")),
                      Step(
                          title: const Text("Delivered"),
                          isActive: currentstep >= 3,
                          state: currentstep >= 3
                              ? StepState.complete
                              : StepState.indexed,
                          content: const Text(
                              "Your order has be delivered and signed by you!")),
                    ])),
          ],
        ),
      )),
    );
  }
}
