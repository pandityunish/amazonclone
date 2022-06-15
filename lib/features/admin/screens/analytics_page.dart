import 'package:amazon_clone/constant/loder.dart';
import 'package:amazon_clone/features/admin/model/admin.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/catogory_product_charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final AdminService adminService = AdminService();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
  }

  void getEarnings() async {
    var earningData = await adminService.getEarning(context);
    totalSales = earningData["totalEaring"];
    earnings = earningData["sales"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductCharts(serieslist: [
                  charts.Series(
                      id: "Sales",
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning)
                ]),
              )
            ],
          );
  }
}
