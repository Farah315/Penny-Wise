import 'package:sqflite/sqflite.dart';

import '../../core/app_constants.dart';
import 'database_helper.dart';
import '../expense_model.dart';


abstract class ExpenseLocalDataSource {
  Future<List<ExpenseModel>> getAllExpenses(String userId);
  Future<ExpenseModel> getExpenseById(String id);
  Future<String> createExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(String id);
  Future<List<ExpenseModel>> getUnsyncedExpenses(String userId);
  Future<void> markAsSynced(String id);
  Future<void> deleteAllExpenses(String userId);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final DatabaseHelper databaseHelper;

  ExpenseLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<ExpenseModel>> getAllExpenses(String userId) async {
    final db = await databaseHelper.database;

    final result = await db.query(
      AppConstants.expensesTable,
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );

    return result.map((map) => ExpenseModel.fromMap(map)).toList();
  }

  @override
  Future<ExpenseModel> getExpenseById(String id) async {
    final db = await databaseHelper.database;

    final result = await db.query(
      AppConstants.expensesTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      throw Exception('Expense not found');
    }

    return ExpenseModel.fromMap(result.first);
  }

  @override
  Future<String> createExpense(ExpenseModel expense) async {
    final db = await databaseHelper.database;

    final id = expense.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final expenseWithId = ExpenseModel(
      id: id,
      userId: expense.userId,
      amount: expense.amount,
      description: expense.description,
      category: expense.category,
      date: expense.date,
      isSynced: expense.isSynced,
    );

    await db.insert(
      AppConstants.expensesTable,
      expenseWithId.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await databaseHelper.database;

    await db.update(
      AppConstants.expensesTable,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  @override
  Future<void> deleteExpense(String id) async {
    final db = await databaseHelper.database;

    await db.delete(
      AppConstants.expensesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<ExpenseModel>> getUnsyncedExpenses(String userId) async {
    final db = await databaseHelper.database;

    final result = await db.query(
      AppConstants.expensesTable,
      where: 'userId = ? AND isSynced = ?',
      whereArgs: [userId, 0],
    );

    return result.map((map) => ExpenseModel.fromMap(map)).toList();
  }

  @override
  Future<void> markAsSynced(String id) async {
    final db = await databaseHelper.database;

    await db.update(
      AppConstants.expensesTable,
      {'isSynced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteAllExpenses(String userId) async {
    final db = await databaseHelper.database;

    await db.delete(
      AppConstants.expensesTable,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
}