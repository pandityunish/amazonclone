import 'package:amazon_clone/common/widgets/costum_textfield.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address-screen";
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatbuidingcontroller = TextEditingController();
  final TextEditingController areacontroller = TextEditingController();
  final TextEditingController pincontroller = TextEditingController();
  final TextEditingController citycontroller = TextEditingController();
  @override
  void dispose() {
    flatbuidingcontroller.dispose();
    areacontroller.dispose();
    pincontroller.dispose();
    citycontroller.dispose();
    super.dispose();
  }

  final AddressServices addressServices = AddressServices();
  String addresstobeuser = "";
  List<PaymentItem> payment = [];
  void onApplepayresult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveuserAddress(
          context: context, address: addresstobeuser);
    }
    addressServices.placedorder(
        context: context,
        address: addresstobeuser,
        totalsum: double.parse(widget.totalAmount));
  }

  void onGooglepayresult(res) {}
  final addressformkey = GlobalKey<FormState>();
  void paypressed(String addressFromProvider) {
    addresstobeuser = "";
    bool isForm = flatbuidingcontroller.text.isNotEmpty ||
        flatbuidingcontroller.text.isNotEmpty ||
        areacontroller.text.isNotEmpty ||
        pincontroller.text.isNotEmpty;
    if (isForm) {
      if (addressformkey.currentState!.validate()) {
        addresstobeuser =
            "${flatbuidingcontroller.text}, ${areacontroller.text},${citycontroller.text},${pincontroller.text},";
      } else {
        throw Exception("Please enter all the value");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addresstobeuser = addressFromProvider;
    }
    print(addresstobeuser);
  }

  @override
  void initState() {
    payment.add(PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                  key: addressformkey,
                  child: Column(
                    children: [
                      CostumFormfield(
                        controller: flatbuidingcontroller,
                        hinttext: "Flat,House on, Building",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CostumFormfield(
                        controller: areacontroller,
                        hinttext: "Area, Street",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CostumFormfield(
                        controller: pincontroller,
                        hinttext: "Pincode",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CostumFormfield(
                        controller: citycontroller,
                        hinttext: "Town or city",
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              ApplePayButton(
                  onPressed: () => paypressed(address),
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 15),
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  paymentConfigurationAsset: "applepay.json",
                  onPaymentResult: onApplepayresult,
                  paymentItems: payment),
              const SizedBox(
                height: 10,
              ),
              GooglePayButton(
                  onPressed: () => paypressed(address),
                  paymentConfigurationAsset: "gpay.json",
                  onPaymentResult: onGooglepayresult,
                  width: double.infinity,
                  height: 50,
                  style: GooglePayButtonStyle.black,
                  type: GooglePayButtonType.buy,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  paymentItems: payment)
            ],
          ),
        ),
      ),
    );
  }
}
