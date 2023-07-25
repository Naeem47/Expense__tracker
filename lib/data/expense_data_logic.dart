import 'package:expensetracker/data/Database.dart';
import 'package:expensetracker/datetime/daytimeformat.dart';
import 'package:expensetracker/models/expensemodel.dart';
import 'package:flutter/material.dart';

class ExpenseDataLogic extends ChangeNotifier {
  // list of all expenses
   List<ExpenseModel> allExpenses = [];

  //get list
  List<ExpenseModel> getList() {
    return allExpenses;
  }
  // prepare data to display
  final db = HiveDataBase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
          allExpenses =db.readData() ;
    }
  }

  // add new expense
  void addNewExpense(ExpenseModel newExpense) {
    allExpenses.add(newExpense);
    db.saveData(allExpenses);
    notifyListeners();
  }

  // remove expense
  void removeExpense(ExpenseModel expense) {
    allExpenses.remove(expense);
    db.saveData(allExpenses);
        notifyListeners();

  }
 String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thr';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get the date for the start of the week ( sunday )
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get todays date
    DateTime today = DateTime.now();

    // go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }


   Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amountTotalforDay
    };

    for (var expense in allExpenses) {
      String date = convertDataTimeToString(expense.date );
      double amount = double.parse(expense.price);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
  
}

