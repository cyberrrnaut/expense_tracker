class Expense {
  final int id;
  final String description;
  final double amount;
  final String date;

  Expense({required this.id, required this.description, required this.amount, required this.date});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
    );
  }
}
