import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddingTransactions extends StatefulWidget {
  final Function addingTransactions;
  AddingTransactions(this.addingTransactions) {
    print("AddingTransactions constructor");
  }

  @override
  _AddingTransactionsState createState() {
    print("AddingTransactionsState createState");
    return _AddingTransactionsState();
  }
}

class _AddingTransactionsState extends State<AddingTransactions> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime _dateTime;

  _AddingTransactionsState() {
    print("AddingTransactionsState constructor");
  }

  @override
  void initState() {
    print("initState()");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddingTransactions oldWidget) {
    print("didUpdate()");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("dispose()");
    super.dispose();
  }

  void _showingDatePicker() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
      ).then(
        (date) {
          if (date == null) {
            return;
          }
          setState(() {
            _dateTime = date;
          });
        },
      );
  void _submittingData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final titleValue = _titleController.text;
    final amountValue = double.parse(_amountController.text);

    if (titleValue.isEmpty || amountValue < 0 || _dateTime == null) {
      return;
    }

    widget.addingTransactions(
      titleValue,
      amountValue,
      _dateTime,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (_) => _submittingData(),
              controller: _titleController,
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submittingData(),
              controller: _amountController,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _dateTime == null
                          ? 'No Date Chosen !'
                          : 'Picked Date:${DateFormat().add_yMd().format(_dateTime)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showingDatePicker,
                    child: Text(
                      'Choose a Date',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submittingData,
              child: Text('Add Transaction'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                foregroundColor:
                    MaterialStateProperty.all(Theme.of(context).buttonColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
