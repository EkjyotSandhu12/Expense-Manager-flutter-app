import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.amount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 16,
          child: FittedBox(
            child: Text(
              'Rs.' + amount.toStringAsFixed(0),
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        // fittedbox, forces the child to get fitted inside the specified container
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          height: 60,
          width: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            alignment: Alignment(0.0, 1),
            heightFactor: spendingPctOfTotal,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
