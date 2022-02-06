import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*variable_type? name_of_variable; means that name_of_variable can be null.

variable_type  name_of_variable1; means that name_of_variable1 cannot be null and you should initialize it immediately.

late variable_type  name_of_variable2; means that name_of_variable2 cannot be null and you can initialize it later.*/

class TransactionAdd extends StatefulWidget {
  //widget class
  final Function addTransactions;


  TransactionAdd(this.addTransactions);

  @override
  State<TransactionAdd> createState() {
    return _TransactionAddState();
  }
}

class _TransactionAddState extends State<TransactionAdd> {
  // state class
  final name = TextEditingController();
  final amount = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    void DatePick() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
      ).then((value){
        if(value == null) return; // if the user presses cancel

        setState(() {
          selectedDate = value;
        });

      });
    }

    void TransactionFilter() {
      if (name.text.isEmpty ||
          double.parse(amount.text) <= 0 ||
          double.parse(amount.text) >= 999999999) return;

      widget.addTransactions(
        // with widget. u can access properties and methods of widget class
        name.text,
        double.parse(amount
            .text),
        selectedDate//make sure the text is in numbers otherwise it will break
      );
      Navigator.of(context).pop(); // pops the modal bottom sheet off
    }

    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: name,
              decoration:
                  const InputDecoration(labelText: 'Name of the Product'),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => TransactionFilter(),
            ),
            TextField(
              controller: amount,
              decoration: const InputDecoration(labelText: 'Enter Cost'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => TransactionFilter(),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Row(
              children: [
                Text(DateFormat('yMMMEd').format((selectedDate))),
                Padding(
                  padding: EdgeInsets.all(7),
                ),
              Expanded(child: Container(alignment: Alignment.centerRight ,child: TextButton(onPressed: DatePick, child: Text('Choose Date')))),
              ],
            ),
            ElevatedButton(
              onPressed: () => {TransactionFilter()},
              child: Text(
                'ADD',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
