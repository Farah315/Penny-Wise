import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:penny_wise/presentation/bloc/expense_bloc.dart';

import 'data/expense_repository_impl.dart';
import 'data/local/database_helper.dart';
import 'data/local/expense_local_datasource.dart';
import 'data/remote/expense_remote_datasource.dart';
import 'domain/expense_repository.dart';
import 'domain/expense_usecase.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => ExpenseBloc(
      getAllExpenses: sl(),
      createExpense: sl(),
      updateExpense: sl(),
      deleteExpense: sl(),
      syncExpenses: sl(),
    ),
  );
  
  sl.registerLazySingleton(() => GetAllExpenses(sl()));
  sl.registerLazySingleton(() => CreateExpense(sl()));
  sl.registerLazySingleton(() => UpdateExpense(sl()));
  sl.registerLazySingleton(() => DeleteExpense(sl()));
  sl.registerLazySingleton(() => SyncExpenses(sl()));
  
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      connectivity: sl(),
    ),
  );
  
  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(databaseHelper: sl()),
  );
  
  sl.registerLazySingleton<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(database: sl()),
  );
  
  sl.registerLazySingleton(() => DatabaseHelper.instance);
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => Connectivity());
}
