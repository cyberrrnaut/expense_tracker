import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          return FutureBuilder(
            future: expenseProvider.fetchExpenses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching expenses'));
              } else {
                return ListView.builder(
                  itemCount: expenseProvider.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenseProvider.expenses[index];
                    return ListTile(
                      title: Text(expense.description),
                      subtitle: Text('${expense.amount} - ${expense.date.toLocal().toShortString()}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          expenseProvider.deleteExpense(expense.id);
                        },
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

extension DateHelpers on DateTime {
  String toShortString() {
    return "${this.year}-${this.month}-${this.day}";
  }
}
