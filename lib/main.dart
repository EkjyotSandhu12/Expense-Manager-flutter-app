import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './Model/TransactionData.dart';
import './Widget/TransactionAdd.dart';
import './Widget/TransactionList.dart';
import 'Widget/Chart.dart';

void main() {
  runApp(App());
}

final List<TransactionData> transactions = [];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // primaryColor: Colors.blueGrey, // primary color is based on one single color
          primarySwatch: Colors.blueGrey,
          // primary swatch is based on single colors with multiple shades
          fontFamily: 'Schyler',
          brightness: Brightness.light,
          textTheme: TextTheme(
            headline6: TextStyle(fontFamily: 'Roboto',color: Colors.red),
            bodyText1: TextStyle(fontSize: 15),
            button: TextStyle(color: Colors.white),
          ),
          buttonTheme: ButtonThemeData(buttonColor: Colors.purple),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 20) //Font weight is 700 for bold
              )),
      debugShowCheckedModeBanner: false,
      title: 'ExpenseManager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void AddTransactions(String title, double amount, DateTime selectedDate) {
    final Tx = TransactionData(
        id: 1, title: title, amount: amount, date: selectedDate);

    setState(() {
      transactions.add(Tx);
    });
  }

  void AddTransactionModalPage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionAdd(AddTransactions);
        });
  }

  List<TransactionData> get lastweek {
    return transactions
        .where((tx) => tx.date
            .isAfter(DateTime.now().subtract(Duration(days: 7)))) // condition
        .toList();
  }

  //listname.where(index){listname[index]}  this function returns a newly created list that has to fullfill a requirement.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Expense Controller'),
        actions: [
          IconButton(
              onPressed: () {
                AddTransactionModalPage(context);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Chart(lastweek),
            TransactionList(transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddTransactionModalPage(context);
          },
          child: Icon(Icons.add)),
    );
  }
}
