import 'package:expense_app/Model/TransactionData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<TransactionData> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text('No Items Added!'),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 300,
                child:
                    Image.asset('Assets/Images/waiting.png', fit: BoxFit.cover),
              )
            ],
          )
        : Container(
            height: 460,
            child: ListView.builder(
                //listview.builder builds widgets only when they can be seen
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight, // same as Expanded( ) widget
                      child: Container(

                          child: Text(
                            'Rs. ${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.all(7),
                          margin: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColorDark,
                                  width: 2))),
                    ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //alignment of the contents on the X - axis
                              children: [
                                Text(
                                  'Name: ' + transactions[index].title,
                                  style: Theme.of(context)
                                      .textTheme.bodyText1, // to access theme of the app bar (mentioned in material constructor)

                                ),
                                Text(
                                    DateFormat('yMMMd')
                                        .format(transactions[index].date),
                                    // $ does .toString() in its own // if we dont use {} it will consider it as object, not value
                                    style: Theme.of(context).textTheme.bodyText1
                                    //accessing global text theme for headline 6,
                                    ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  );
                }),
          );
  }
}
