import 'package:flutter/material.dart';

class TransactionAdd extends StatefulWidget { //widget class
  final Function addTransactions;

  const TransactionAdd(this.addTransactions);

  @override
  State<TransactionAdd> createState() { return _TransactionAddState(); }
}

class _TransactionAddState extends State<TransactionAdd> { // state class
  final name = TextEditingController();

  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void TransactionFilter(){
      if(name.text.isEmpty || double.parse(amount.text) <= 0 || double.parse(amount.text) >= 999999999) return;

      widget.addTransactions( // with widget. u can access properties and methods of widget class
        name.text,
        double.parse(amount.text), //make sure the text is in numbers otherwise it will break
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
              decoration: const InputDecoration(labelText: 'Name of the Product'),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => TransactionFilter(),
            ),
            TextField(
              controller: amount,
              decoration: const InputDecoration(labelText: 'Enter Cost'),
                keyboardType: TextInputType.number,
              onSubmitted: (_) => TransactionFilter(),
            ),
            TextButton(
                onPressed: () => {
                  TransactionFilter()
                    },
                child: const Text(
                  'ADD',
                  style: TextStyle(color: Colors.purple),
                )),
          ],
        ),
      ),
    );
  }
}
