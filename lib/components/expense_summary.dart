import 'package:expense_tracker_app/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bar graph/bar_graph.dart';
import '../datetime/date_time_helper.dart';

class ExpenseSummary extends StatelessWidget {
    final DateTime startOfWeek;
    const ExpenseSummary(
        {super.key,
        required this.startOfWeek,
        });


        // calculate max amount in bar graph

        double calculateMax(
            ExpenseData value,
            String sunday,
             String monday,
              String tuesday,
               String wednesday,
                String thursday,
                 String friday,
                  String saturday,

        )
        {
            double? max = 100;
            List<double> values= [
                value.calculatedailyexpenseSummary()[sunday]?? 0,
                value.calculatedailyexpenseSummary()[monday]?? 0,
                value.calculatedailyexpenseSummary()[tuesday]?? 0,
                value.calculatedailyexpenseSummary()[wednesday]?? 0,
                value.calculatedailyexpenseSummary()[thursday]?? 0,
                value.calculatedailyexpenseSummary()[friday]?? 0,
                value.calculatedailyexpenseSummary()[saturday]?? 0,

            ];

            // sort from smallest to largest
            values.sort();
            // get largest amount (which is at the end of the sorted list)
            //increase the cap slightly so the graph looks almost full

            max= values.last * 1.1;
            return max== 0? 100: max;
        }

        //calculate the week total
        String calculateWeekTotal(
             ExpenseData value,
            String sunday,
             String monday,
              String tuesday,
               String wednesday,
                String thursday,
                 String friday,
                  String saturday,
                  

        ) {
             List<double> values= [
                value.calculatedailyexpenseSummary()[sunday]?? 0,
                value.calculatedailyexpenseSummary()[monday]?? 0,
                value.calculatedailyexpenseSummary()[tuesday]?? 0,
                value.calculatedailyexpenseSummary()[wednesday]?? 0,
                value.calculatedailyexpenseSummary()[thursday]?? 0,
                value.calculatedailyexpenseSummary()[friday]?? 0,
                value.calculatedailyexpenseSummary()[saturday]?? 0,

            ];
            double total = 0;
            for(int i = 0; i< values.length; i++) {
                total += values[i];
            }
            return total.toStringAsFixed(2);
        }

    @override
    Widget build(BuildContext context) {
        // get ddmmyyyy for each day of this week
        String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0))); 
        String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1))); 
        String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2))); 
        String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
        String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4))); 
        String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5))); 
        String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6))); 
        return Consumer<ExpenseData>
(
            builder: (context, value,child)=> Column(
                children: [
                    // week total
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                    child: Row(
                        children: [
                            const Text('Week Total:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}'),

            
                        ],
                    ),
            ),

                    // bar graph
                SizedBox(
                height: 200,
                child: MyBarGraph(
                    maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
                    sunAmount: value.calculatedailyexpenseSummary() [sunday]?? 0,
                    monAmount: value.calculatedailyexpenseSummary() [monday]?? 0,
                    tueAmount: value.calculatedailyexpenseSummary() [tuesday]?? 0,
                    wedAmount: value.calculatedailyexpenseSummary() [wednesday]?? 0,
                    thurAmount:value.calculatedailyexpenseSummary() [thursday]?? 0,
                    friAmount: value.calculatedailyexpenseSummary() [friday]?? 0,
                    satAmount: value.calculatedailyexpenseSummary() [saturday]?? 0,
                ),
            ),
            ],
            ),
            
        );
    }
     }