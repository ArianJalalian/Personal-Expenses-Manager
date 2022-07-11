import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';
import '../models/bar_info.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  Chart(this.transactions);

  List<BarInfo> get listOfBars {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        var amount = 0.0;
        for (var i = 0; i < transactions.length; i++) {
          if (transactions[i].date.day == weekDay.day &&
              transactions[i].date.month == weekDay.month &&
              transactions[i].date.year == weekDay.year) {
            amount += transactions[i].amount;
          }
        }

        var sum = 0.0;
        for (var i = 0; i < transactions.length; i++)
          sum += transactions[i].amount;
        final amountPctOfAll = sum == 0 ? 0.0 : amount / sum;

        return BarInfo(
          day: DateFormat.E().format(weekDay).substring(0, 1),
          amount: amount,
          pctOfAllWeek: amountPctOfAll,
        );
      },
    ).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...listOfBars.map(
                (data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      day: data.day,
                      spendingAmount: data.amount,
                      spendingPct: data.pctOfAllWeek,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
