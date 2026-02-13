import '../domain/expense.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    super.id,
    required super.userId,
    required super.amount,
    required super.description,
    required super.category,
    required super.date,
    super.isSynced,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String?,
      userId: map['userId'] as String,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String,
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
      isSynced: (map['isSynced'] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'isSynced': isSynced ? 1 : 0,
    };
  }

  factory ExpenseModel.fromFirebase(String key, Map<dynamic, dynamic> data) {
    return ExpenseModel(
      id: key,
      userId: data['userId'] as String,
      amount: (data['amount'] as num).toDouble(),
      description: data['description'] as String,
      category: data['category'] as String,
      date: DateTime.parse(data['date'] as String),
      isSynced: true,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'userId': userId,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      userId: expense.userId,
      amount: expense.amount,
      description: expense.description,
      category: expense.category,
      date: expense.date,
      isSynced: expense.isSynced,
    );
  }
}