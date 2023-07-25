import 'package:expensetracker/data/expense_data_logic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../bargraph/graph.dart';
import '../datetime/daytimeformat.dart';

class Chatcont extends StatelessWidget {
  final DateTime startOfWeek;

  const Chatcont({super.key, required this.startOfWeek});

  double calculateMax(
    ExpenseDataLogic value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseDataLogic value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];

    double total = 0;
    for (var i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDataTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseDataLogic>(
      builder: (context, value, child) => Container(
        width: MediaQuery.of(context).size.width,
        height: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                              children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weekly Expense",
                        style: GoogleFonts.readexPro(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$ ${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}",
                        style: GoogleFonts.readexPro(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                              ],
                            ),
                )),
            Expanded(
              flex: 2,
              child: Graphxx(
                mon: value.calculateDailyExpenseSummary()[monday] ?? 0,
                tue: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                wed: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                thu: value.calculateDailyExpenseSummary()[thursday] ?? 0,
                fri: value.calculateDailyExpenseSummary()[friday] ?? 0,
                sat: value.calculateDailyExpenseSummary()[saturday] ?? 0,
                sun: value.calculateDailyExpenseSummary()[sunday] ?? 0,
                maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                    thursday, friday, saturday),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
