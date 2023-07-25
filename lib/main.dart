import 'package:expensetracker/screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'data/expense_data_logic.dart';

void main()async {
  await Hive.initFlutter();
  await Hive.openBox("mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseDataLogic(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home:  Splash(),
      ),
    );
  }
}
