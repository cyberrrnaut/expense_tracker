import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/api_service.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  final ApiService apiService = ApiService();

  List<Expense> get expenses => _expenses;

  Future<void> fetchExpenses() async {
    _expenses = await apiService.fetchExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await apiService.addExpense(expense);
    await fetchExpenses(); // Refresh the list after adding
  }

  Future<void> deleteExpense(int id) async {
    await apiService.deleteExpense(id);
    await fetchExpenses(); // Refresh the list after deletion
  }
}
