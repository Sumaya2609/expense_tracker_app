import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_item.dart';

class HiveDataBase {
    // refence our box
    final _myBox = Hive.box("expense_database2");

    // write data
    void saveData(List<ExpenseItem> allExpense)
 {

        /*
        Hive can only store the strings nd dateTime and not custome objects like ExpenseItem.
        Convert expenseItem objects into types that can store in db.

        allExpense= 

        [
            ExpenseItem (name/ amount/ dateTime)
        ]

        ->  

        [
            [name, amount, dateTime]
        ]

        */

        List<List<dynamic>> allExpenseFormatted= [];

        for (var expense in allExpense)
        {
        // convert each expenseItem into a list of storable type (strings, dateTime)
        List<dynamic> expenseFormatted= [
            expense.name,
            expense.amount,
            expense.dateTime,
        ];
        allExpenseFormatted.add(expenseFormatted);
        }

        // finally store in db
        _myBox.put("ALL_EXPENSES", allExpenseFormatted);

    }

    // read data
        /*
        Data is stored in Hive as a list of strings + dateTime 
        so lets convert our saved data into ExpenseItem Objects

        Saveddata =

        [
            [name, amount, dateTime],
            ..
        ]

        ->

        [
            ExpenseItem (name, amount, dateTime ),
            ..
        ]

        */

        List<ExpenseItem> readData() {
  List savedExpense = _myBox.get("ALL_EXPENSES") ?? [];
  List<ExpenseItem> allExpenses = [];

  for (int i = 0; i < savedExpense.length; i++) {
    String name = savedExpense[i][0] as String;
    String amount = savedExpense[i][1] as String;
    DateTime dateTime = savedExpense[i][2] as DateTime;

    ExpenseItem expense = ExpenseItem(
      name: name,
      amount: amount,
      dateTime: dateTime,
    );
    allExpenses.add(expense);
  }

  return allExpenses; 
}

        }

