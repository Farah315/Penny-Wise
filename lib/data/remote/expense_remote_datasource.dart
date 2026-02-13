import 'package:firebase_database/firebase_database.dart';

import '../../core/app_constants.dart';
import '../expense_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<List<ExpenseModel>> getAllExpenses(String userId);
  Future<String> createExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id, String userId);
  Future<void> syncExpenses(List<ExpenseModel> expenses, String userId);
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final FirebaseDatabase database;

  ExpenseRemoteDataSourceImpl({required this.database});

  DatabaseReference _getUserExpensesRef(String userId) {
    return database.ref().child(AppConstants.usersPath).child(userId).child(AppConstants.expensesPath);
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses(String userId) async {
    try {
      final snapshot = await _getUserExpensesRef(userId).get();

      if (!snapshot.exists) {
        return [];
      }

      final Map<dynamic, dynamic> expensesMap = snapshot.value as Map<dynamic, dynamic>;
      final List<ExpenseModel> expenses = [];

      expensesMap.forEach((key, value) {
        expenses.add(ExpenseModel.fromFirebase(key, value as Map<dynamic, dynamic>));
      });

      // Sort by date descending
      expenses.sort((a, b) => b.date.compareTo(a.date));

      return expenses;
    } catch (e) {
      throw Exception('Failed to fetch expenses from Firebase: $e');
    }
  }

  @override
  Future<String> createExpense(ExpenseModel expense) async {
    try {
      final ref = _getUserExpensesRef(expense.userId);

      if (expense.id != null) {
        // Use existing ID
        await ref.child(expense.id!).set(expense.toFirebase());
        return expense.id!;
      } else {
        // Generate new ID
        final newRef = ref.push();
        await newRef.set(expense.toFirebase());
        return newRef.key!;
      }
    } catch (e) {
      throw Exception('Failed to create expense in Firebase: $e');
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      if (expense.id == null) {
        throw Exception('Expense ID is required for update');
      }

      await _getUserExpensesRef(expense.userId)
          .child(expense.id!)
          .update(expense.toFirebase());
    } catch (e) {
      throw Exception('Failed to update expense in Firebase: $e');
    }
  }

  @override
  Future<void> deleteExpense(String id, String userId) async {
    try {
      await _getUserExpensesRef(userId).child(id).remove();
    } catch (e) {
      throw Exception('Failed to delete expense from Firebase: $e');
    }
  }

  @override
  Future<void> syncExpenses(List<ExpenseModel> expenses, String userId) async {
    try {
      final ref = _getUserExpensesRef(userId);

      for (var expense in expenses) {
        if (expense.id != null) {
          await ref.child(expense.id!).set(expense.toFirebase());
        }
      }
    } catch (e) {
      throw Exception('Failed to sync expenses to Firebase: $e');
    }
  }
}