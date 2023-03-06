import 'package:flutter/material.dart';
import 'package:yahoo_finances_module/Models/stock_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ActiveChart extends StatelessWidget {
  final List<FStockChart> data;

  ActiveChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<FStockChart, DateTime>> series = [
      charts.Series(
        id: "ActiveChart",
        data: data,
        domainFn: (FStockChart series, _) => series.date,
        measureFn: (FStockChart sales, _) => sales.openValue,
      )
    ];
    return charts.TimeSeriesChart(
      series,
      animate: true,
      
    );
  }
}
