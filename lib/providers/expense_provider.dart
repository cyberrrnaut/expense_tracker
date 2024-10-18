import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/api_service.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  bool _isLoading = false;
  final ApiService apiService = ApiService();

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;  

  Future<void> fetchExpenses() async {
    _isLoading = true;
    notifyListeners();  

    _expenses = await apiService.fetchExpenses();
    
    _isLoading = false;
    notifyListeners();  
  }

  Future<void> updateExpense(int id, String description, double amount, String date) async {
  await apiService.updateExpense(id, description, amount, date);
  await fetchExpenses(); 
}


  Future<void> addExpense(String description, double amount, String date) async {
    await apiService.addExpense(description, amount, date);
    await fetchExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await apiService.deleteExpense(id);
    await fetchExpenses(); 
  }
}
