import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    await Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
    setState(() {
      _isLoading = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<ExpenseProvider>(
              builder: (context, expenseProvider, child) {
                return ListView.builder(
                  itemCount: expenseProvider.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenseProvider.expenses[index];
                    return ListTile(
                      title: Text(expense.description),
                      subtitle: Text('${expense.amount} - ${expense.date.toLocal().toShortString()}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(context, expense);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              expenseProvider.deleteExpense(expense.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  void _showEditDialog(BuildContext context, Expense expense) {
    final descriptionController = TextEditingController(text: expense.description);
    final amountController = TextEditingController(text: expense.amount.toString());
    final dateController = TextEditingController(text: expense.date.toLocal().toShortString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final description = descriptionController.text;
                final amount = double.tryParse(amountController.text);
                final date = dateController.text;

                if (amount != null && description.isNotEmpty && date.isNotEmpty) {
                  await Provider.of<ExpenseProvider>(context, listen: false)
                      .updateExpense(expense.id, description, amount, date);
                  Navigator.of(context).pop(); 
                  _fetchExpenses(); 
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

extension on DateTime {
  String toShortString() {
    return "${this.year}-${this.month}-${this.day}";
  }
}
