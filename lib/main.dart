import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './Model/TransactionData.dart';
import './Widget/TransactionAdd.dart';
import './Widget/TransactionList.dart';
import 'Widget/Chart.dart';

//system chrome allows you to set some system wide settings for your app

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);*/
  runApp(App());
}

final List<TransactionData> transactions = [];
bool showChart = true;

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
            headline6: TextStyle(fontFamily: 'Roboto', color: Colors.red),
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
        id: title +
            selectedDate.toString() +
            amount.toString() +
            new Random(10000000).toString(),
        title: title,
        amount: amount,
        date: selectedDate);
    setState(() {
      transactions.add(Tx);
    });
  }

  void deleteTransactions(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void AddTransactionModalPage(BuildContext context) {

    showModalBottomSheet(
      isScrollControlled: true, //scrolling the entire sheet //https://api.flutter.dev/flutter/widgets/DraggableScrollableSheet-class.html
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TransactionAdd(AddTransactions),
        );
      },
    );
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
    // bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Your Expense Controller'),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: FittedBox(
              child: Column(children: [
                Switch(
                    value: showChart,
                    onChanged: (value) {
                      setState(() {
                        showChart = value;
                      });
                    }),
                Text('Show Chart')
              ]),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (showChart) Chart(lastweek),
          Flexible(
            child: TransactionList(transactions, deleteTransactions),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddTransactionModalPage(context);
          },
          child: Icon(Icons.add)),
    );
  }
}
