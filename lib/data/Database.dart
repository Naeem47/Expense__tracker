import 'package:expensetracker/models/expensemodel.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveDataBase {
  // reference my box
  final _myBox = Hive.box('mybox');

  // write data
  void saveData(List<ExpenseModel> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.price,
        expense.date,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // read data
  List<ExpenseModel> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseModel> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String price = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseModel expense =
          ExpenseModel(name: name, price: price, date: dateTime);

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}