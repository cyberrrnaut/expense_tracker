import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class ApiService {
  // Base URL
  final String baseUrl = 'https://flutter-be.cyb3rnaut.com';

  // Fetch all expenses (GET /expenses)
  Future<List<Expense>> fetchExpenses() async {
    final response = await http.get(Uri.parse('$baseUrl/expenses'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((expense) => Expense.fromJson(expense)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  // Add a new expense (POST /expenses)
  Future<void> addExpense(String description, double amount, String date) async {
    final response = await http.post(
      Uri.parse('$baseUrl/expenses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'description': description,
        'amount': amount,
        'date': date,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add expense');
    }
  }

  // Update an expense (PUT /expenses/:id)
  Future<void> updateExpense(int id, String description, double amount, String date) async {
    final response = await http.put(
      Uri.parse('$baseUrl/expenses/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'description': description,
        'amount': amount,
        'date': date,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update expense');
    }
  }

  // Delete an expense (DELETE /expenses/:id)
  Future<void> deleteExpense(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/expenses/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete expense');
    }
  }
}
