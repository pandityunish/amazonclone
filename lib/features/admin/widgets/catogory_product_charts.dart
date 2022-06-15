import 'package:amazon_clone/features/admin/model/admin.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CategoryProductCharts extends StatelessWidget {
  final List<charts.Series<Sales, String>> serieslist;
  const CategoryProductCharts({Key? key, required this.serieslist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      serieslist,
      animate: true,
    );
  }
}
