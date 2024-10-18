import 'package:expense_tracker/screens/expense_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class AddExpenseScreen extends StatelessWidget {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date (yyyy-mm-dd)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final description = _descriptionController.text;
                final amount = double.tryParse(_amountController.text) ?? 0.0;
                final date = _dateController.text;

                if (description.isNotEmpty && date.isNotEmpty && amount > 0) {
 
                   await Provider.of<ExpenseProvider>(context, listen: false)
                      .addExpense(description, amount, date);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ExpenseListScreen()),
                  );
                }
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
