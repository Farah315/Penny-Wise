import 'package:dartz/dartz.dart';
import '../core/app_exception.dart';
import 'expense.dart';

abstract class ExpenseRepository {
  Future<Either<AppException, List<Expense>>> getAllExpenses(String userId);
  Future<Either<AppException, Expense>> getExpenseById(String id);
  Future<Either<AppException, String>> createExpense(Expense expense);
  Future<Either<AppException, void>> updateExpense(Expense expense);
  Future<Either<AppException, void>> deleteExpense(String id, String userId);
  Future<Either<AppException, void>> syncExpenses(String userId);
}