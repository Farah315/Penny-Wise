import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:penny_wise/data/remote/expense_remote_datasource.dart';

import '../core/app_exception.dart';
import '../domain/expense.dart';
import '../domain/expense_repository.dart';
import 'expense_model.dart';
import 'local/expense_local_datasource.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;
  final ExpenseRemoteDataSource remoteDataSource;
  final Connectivity connectivity;

  ExpenseRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.connectivity,
  });

  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Future<Either<AppException, List<Expense>>> getAllExpenses(String userId) async {
    try {
      final localExpenses = await localDataSource.getAllExpenses(userId);

      if (await isConnected) {
        try {
          final unsyncedExpenses = await localDataSource.getUnsyncedExpenses(
            userId,
          );
          if (unsyncedExpenses.isNotEmpty) {
            await remoteDataSource.syncExpenses(unsyncedExpenses, userId);
            for (var expense in unsyncedExpenses) {
              if (expense.id != null) {
                await localDataSource.markAsSynced(expense.id!);
              }
            }
          }

          final remoteExpenses = await remoteDataSource.getAllExpenses(userId);

          for (var remoteExpense in remoteExpenses) {
            try {
              await localDataSource.getExpenseById(remoteExpense.id!);

              await localDataSource.updateExpense(remoteExpense);
            } catch (e) {
              await localDataSource.createExpense(remoteExpense);
            }
          }

          final updatedExpenses = await localDataSource.getAllExpenses(userId);
          return Right(updatedExpenses);
        } catch (e) {
          print("Sync failed, returning local data: ${e.toString()}");
          return Right(localExpenses);
        }
      }

      return Right(localExpenses);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppException, Expense>> getExpenseById(String id) async {
    try {
      final expense = await localDataSource.getExpenseById(id);
      return Right(expense);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppException, String>> createExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);

      final id = await localDataSource.createExpense(expenseModel);

      if (await isConnected) {
        try {
          await remoteDataSource.createExpense(
            expenseModel.copyWith(id: id, isSynced: true) as ExpenseModel,
          );
          await localDataSource.markAsSynced(id);
        } catch (e) {
          print("Failed to sync with remote: ${e.toString()}");
        }
      }

      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> updateExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);

      await localDataSource.updateExpense(expenseModel);

      if (await isConnected) {
        try {
          await remoteDataSource.updateExpense(
            expenseModel.copyWith(isSynced: true) as ExpenseModel,
          );
          await localDataSource.markAsSynced(expense.id!);
        } catch (e) {
          print("Failed to update remote: ${e.toString()}");
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> deleteExpense(String id, String userId) async {
    try {
      await localDataSource.deleteExpense(id);

      if (await isConnected) {
        try {
          await remoteDataSource.deleteExpense(id, userId);
        } catch (e) {
          print("Failed to delete from remote: ${e.toString()}");
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> syncExpenses(String userId) async {
    try {
      if (!await isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final unsyncedExpenses = await localDataSource.getUnsyncedExpenses(
        userId,
      );

      if (unsyncedExpenses.isEmpty) {
        return const Right(null);
      }

      await remoteDataSource.syncExpenses(unsyncedExpenses, userId);

      for (var expense in unsyncedExpenses) {
        if (expense.id != null) {
          await localDataSource.markAsSynced(expense.id!);
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
