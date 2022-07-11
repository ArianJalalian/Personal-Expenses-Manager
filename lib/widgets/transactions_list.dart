import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletingTx;
  const TransactionsList(
      {@required this.transactions, @required this.deletingTx});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constarins) {
                return Column(
                  children: [
                    SizedBox(
                      height: constarins.maxHeight * 0.05,
                    ),
                    const Text(
                      'the transactions list is empty!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: constarins.maxHeight * 0.05,
                    ),
                    Container(
                      height: constarins.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  mediaQuery: mediaQuery,
                  deletingTx: deletingTx,
                  transaction: transactions[index],
                );
              },
            ),
    );
  }
}
