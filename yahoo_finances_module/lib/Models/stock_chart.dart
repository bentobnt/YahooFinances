class StockChart {
  final String date;
  final String openValue;

  StockChart({required this.date, required this.openValue});

  factory StockChart.fromJson(dynamic json) {
    return StockChart(
        date: json['date'] as String, openValue: json['open'] as String);
  }
}

class FStockChart {
  final double openValue;
  final DateTime date;

  FStockChart({required this.date, required this.openValue});

  factory FStockChart.fromJson(dynamic json) {
    double openValueDouble = double.parse(json['open']);
    final splitted = json['date'].split('/');
    final year = int.parse(splitted[2]);
    final month = int.parse(splitted[1]);
    final day = int.parse(splitted[0]);
    DateTime dateFormatted = DateTime(year, month, day);
    return FStockChart(
        date: dateFormatted, openValue: openValueDouble);
  }
}
