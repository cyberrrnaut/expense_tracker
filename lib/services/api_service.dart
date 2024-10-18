import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class ApiService {
  final String baseUrl = 'https://flutter-be.cyb3rnaut.com';

  Future<List<Expense>> fetchExpenses() async {
    final response = await http.get(Uri.parse('$baseUrl/expenses'));

    //print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((expense) => Expense.fromJson(expense)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<void> addExpense(
      String description, double amount, String date) async {
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
      print('Failed to add expense');
      throw Exception('Failed to add expense');
    }
  }

  Future<void> updateExpense(
      int id, String description, double amount, String date) async {
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
     print('Failed to update expense');
      throw Exception('Failed to update expense');
    }
  }

  Future<void> deleteExpense(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/expenses/$id'));

    if (response.statusCode != 204) {
          print('Failed to delete expense'); 
      throw Exception('Failed to delete expense');
    }
  }
}
