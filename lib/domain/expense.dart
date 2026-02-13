import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String? id;
  final String userId;
  final double amount;
  final String description;
  final String category;
  final DateTime date;
  final bool isSynced;

  const Expense({
    this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    this.isSynced = false,
  });

  @override
  List<Object?> get props => [id, userId, amount, description, category, date, isSynced];

  Expense copyWith({
    String? id,
    String? userId,
    double? amount,
    String? description,
    String? category,
    DateTime? date,
    bool? isSynced,
  }) {
    return Expense(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}