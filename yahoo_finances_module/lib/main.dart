import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yahoo_finances_module/Models/stock_chart.dart';
import 'package:yahoo_finances_module/pages/active_chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yahoo Finances',
      home: Scaffold(
        body: SafeArea(
          bottom: false,
          child: SizedBox.expand(
            child: MyHomePage(title: 'Gráfico do ativo'),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _channel = const MethodChannel('flutter_channel');
  dynamic jsonDataFromNative;
  List<FStockChart> fstockChartData = [];

  void backToNative() {
    _channel.invokeMethod('close_flutter');
  }

  void setupMethodChannel() {
    _channel.setMethodCallHandler(_handleMessage);
  }

  Future<dynamic> _handleMessage(MethodCall call) async {
    if (call.method == 'getNativeData') {
      jsonDataFromNative = await call.arguments;
      await mapJson();
    }
  }

  Future<List<FStockChart>> mapJson() async {
    final jsonList = await jsonDataFromNative as List;
    fstockChartData = [];
    for (var element in jsonList) {
      fstockChartData.add(FStockChart.fromJson(element));
    }
    setState(() {});
    return fstockChartData;
  }

  @override
  void initState() {
    super.initState();
    setupMethodChannel();
  }

  @override
  Widget build(BuildContext context) {
    num percent_of_change(num num1, num num2) => ((num2 - num1) / num1) * 100;
    String percenteValue = '';
    String initialPrice = '';
    String finalPrice = '';
    if (fstockChartData.isNotEmpty) {
      percenteValue = percent_of_change(
              fstockChartData[0].openValue, fstockChartData.last.openValue)
          .toStringAsFixed(2);

      initialPrice = fstockChartData[0].openValue.toString();
      finalPrice = fstockChartData.last.openValue.toString();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB281248),
        title: const Text('Variação nos últimos 30 dias'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'APPL ($percenteValue)',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8,
                top: 20,
              ),
              child: SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: ActiveChart(
                  data: fstockChartData,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text('Preço inicial: $initialPrice'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Preço final: $finalPrice'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Center(
                child: ElevatedButton(
                  onPressed: backToNative,
                  child: const Text('Voltar pro iOS'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
