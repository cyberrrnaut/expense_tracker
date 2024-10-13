import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class ApiService {
  // Use the IP address of your computer
  final String baseUrl = 'http://192.168.29.96:8000/controllers'; // Replace with your computer's IP address

  Future<List<Expense>> fetchExpenses() async {
    final response = await http.get(Uri.parse('$baseUrl/get_expenses.php'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((expense) => Expense.fromJson(expense)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<void> addExpense(Expense expense) async {
    await http.post(
      Uri.parse('$baseUrl/add_expense.php'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'description': expense.description,
        'amount': expense.amount.toString(),
        'date': expense.date,
      },
    );
  }

  Future<void> deleteExpense(int id) async {
    await http.delete(Uri.parse('$baseUrl/delete_expense.php?id=$id'));
  }
}
