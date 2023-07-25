import 'package:expensetracker/data/expense_data_logic.dart';
import 'package:expensetracker/models/expensemodel.dart';
import 'package:expensetracker/widgets/charcont.dart';
import 'package:expensetracker/widgets/expensetile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String expense = '200';

  TextEditingController name = TextEditingController();

  TextEditingController price = TextEditingController();

  List<Color> color = const [
    Color(0xFFFF80AB),
    Color(0xFF80D8FF),
    Color(0xFFFFD740),
    Color(0xFF64FFDA),
    Color(0xFFE040FB),
    Color(0xFF536DFE),
    Color(0xFF69F0AE),
    Color(0xFFFFAB40),
    Color(0xFF18FFFF),
    Color(0xFFFF5252),
  ];

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
   final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();
  @override
  void initState() {
    
    super.initState();
    Provider.of<ExpenseDataLogic>(context, listen: false).prepareData();
    
  }

  @override
  Widget build(BuildContext context) {
    deleteExpense(ExpenseModel expense) {
      Provider.of<ExpenseDataLogic>(context, listen: false)
          .removeExpense(expense);
    }

    save() {
      ExpenseModel newExpense = ExpenseModel(
        name: name.text,
        price: price.text,
        date: DateTime.now(),
      );
      Provider.of<ExpenseDataLogic>(context, listen: false)
          .addNewExpense(newExpense);
      name.clear();
      price.clear();
      Navigator.pop(context);
    }

    onpressed() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => SizedBox(
          height: 200,
          width: 300,
          child: AlertDialog(
            content: Wrap(
              children: [
                Text(
                  "Add New Expense",
                  style: GoogleFonts.lato(
                      color: Colors.grey.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: name,
                                    cursorColor: Colors.black,

                  decoration: const InputDecoration(
                    hintText: "Expense",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: price,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "Amount",
                    
                    focusColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: save,
                      child: const Text("Save"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        name.clear();
                        price.clear();
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return Consumer<ExpenseDataLogic>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Statstics",
              style: GoogleFonts.readexPro(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          backgroundColor: const Color(0xffF6F6F6),
          floatingActionButton: FloatingActionButton(
              elevation: 2,
              backgroundColor: Colors.black,
              onPressed: onpressed,
              child: const Icon(Icons.add,color: Colors.white,)),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                height: 10,
                ),
                 
                Chatcont(startOfWeek: value.startOfWeekDate()),
                const SizedBox(
                height: 10,
                ),
                Text(
                  "Expense List",
                  style: GoogleFonts.readexPro(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: value.allExpenses.length,
                    itemBuilder: (BuildContext context, int index) {
                    
                      
                    return  ExpenseTile(
                          onpressed: (p0) =>
                              deleteExpense(value.getList()[index]),
                          t: value.getList()[index].name[0],
                          color: color[index].withOpacity(0.8),
                          expensename: value.getList()[index].name,
                          expenseprice: value.getList()[index].price);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
