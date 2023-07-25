import 'package:expensetracker/bargraph/bardatadata.dart';
import 'package:expensetracker/data/expense_data_logic.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Graphxx extends StatelessWidget {
  final double maxY;
  final double mon;
  final double tue;
  final double wed;
  final double thu;
  final double fri;
  final double sat;
  final double sun;
  const Graphxx({
    super.key,
    required this.maxY,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
  });

  @override
  Widget build(BuildContext context) {
       
    // initialize the data

    BarData mybarData = BarData(
        monAmount: mon, tueAmount: tue, wedAmount: wed, thrAmount: thu, friAmount: fri, satAmount: sat, sunAmount: sun);
    mybarData.initializeBarData();
    return Consumer<ExpenseDataLogic>(
      builder: (context, value, child) => 
       Padding(
        padding: const EdgeInsets.all(10.0),
        child: BarChart(BarChartData(
          maxY:maxY,
          minY: 0,
          titlesData: const FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
              ))),
          gridData:const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: mybarData.barData
              .map((data) => BarChartGroupData(x: data.x, barRods: [
                    BarChartRodData(
                        toY: data.y,
                        color: Colors.black,
                        width: 12,
                        borderRadius: BorderRadius.circular(24),
                        backDrawRodData: BackgroundBarChartRodData(
                            show: true, toY: maxY, color: Colors.grey.shade200)),
                  ]))
              .toList(),
        )),
    ),
    );
  }
}
Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'S',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'M',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'W',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'F',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'S',
        style: style,
      );
      break;

    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}