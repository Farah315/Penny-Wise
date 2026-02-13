import 'package:equatable/equatable.dart';

import '../../domain/expense.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();
  
  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {
  final String userId;
  
  const LoadExpenses(this.userId);
  
  @override
  List<Object?> get props => [userId];
}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  
  const AddExpense(this.expense);
  
  @override
  List<Object?> get props => [expense];
}

class UpdateExpenseEvent extends ExpenseEvent {
  final Expense expense;
  
  const UpdateExpenseEvent(this.expense);
  
  @override
  List<Object?> get props => [expense];
}

class DeleteExpenseEvent extends ExpenseEvent {
  final String id;
  final String userId;
  
  const DeleteExpenseEvent(this.id, this.userId);
  
  @override
  List<Object?> get props => [id, userId];
}

class SyncExpensesEvent extends ExpenseEvent {
  final String userId;
  
  const SyncExpensesEvent(this.userId);
  
  @override
  List<Object?> get props => [userId];
}
