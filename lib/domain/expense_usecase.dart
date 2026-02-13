import 'package:dartz/dartz.dart';
import '../core/app_exception.dart';
import 'expense.dart';
import 'expense_repository.dart';


class GetAllExpenses {
  final ExpenseRepository repository;

  GetAllExpenses(this.repository);

  Future<Either<AppException, List<Expense>>> call(String userId) async {
    return await repository.getAllExpenses(userId);
  }
}

class CreateExpense {
  final ExpenseRepository repository;

  CreateExpense(this.repository);

  Future<Either<AppException, String>> call(Expense expense) async {
    return await repository.createExpense(expense);
  }
}

class UpdateExpense {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  Future<Either<AppException, void>> call(Expense expense) async {
    return await repository.updateExpense(expense);
  }
}

class DeleteExpense {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  Future<Either<AppException, void>> call(String id, String userId) async {
    return await repository.deleteExpense(id, userId);
  }
}

class SyncExpenses {
  final ExpenseRepository repository;

  SyncExpenses(this.repository);

  Future<Either<AppException, void>> call(String userId) async {
    return await repository.syncExpenses(userId);
  }
}