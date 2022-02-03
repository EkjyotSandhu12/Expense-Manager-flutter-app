import 'package:expense_app/Model/TransactionData.dart';
import 'package:expense_app/Widget/Chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<TransactionData> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get WeekTransactionsList {
    return List.generate(7, (index) {
      // this will generate the list of last 7 days with specific Day and money spent on that Day.

      DateTime weekDay = DateTime.now().subtract(Duration(
          days: index)); // accessing last 7 days one by one, in every iteration
      double totalValue = 0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalValue += recentTransaction[i]
              .amount; //gathering all the amount that we spent on that day (weekDay)
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        // E returns weekday name on that day
        'value': totalValue
      }; // 1 day of last 7 day
    });
  }

  double get totalSpendingLastWeek {
    return WeekTransactionsList.fold(0.0, (previousValue, element) {
      return previousValue + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(WeekTransactionsList);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //effects individual items in row/column
          children: [
            ...WeekTransactionsList.map(
              (e) {
                return Flexible(
                  child: ChartBar(
                        e['day'].toString(),
                        (e['value'] as double),
                        e['value'] as double <= 0
                            ? 0
                            : (e['value'] as double) / totalSpendingLastWeek),
                );//A widget that controls how a child of a Row, Column takes space.

              },
            ),
          ],
        ),
      ),
    );
  }
}
