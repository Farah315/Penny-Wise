import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/expense_usecase.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetAllExpenses getAllExpenses;
  final CreateExpense createExpense;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;
  final SyncExpenses syncExpenses;
  
  ExpenseBloc({
    required this.getAllExpenses,
    required this.createExpense,
    required this.updateExpense,
    required this.deleteExpense,
    required this.syncExpenses,
  }) : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<DeleteExpenseEvent>(_onDeleteExpense);
    on<SyncExpensesEvent>(_onSyncExpenses);
  }
  
  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    
    final result = await getAllExpenses(event.userId);
    
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (expenses) => emit(ExpenseLoaded(expenses)),
    );
  }
  
  Future<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final result = await createExpense(event.expense);
    
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (id) {
        emit(const ExpenseOperationSuccess('Expense added successfully'));
        add(LoadExpenses(event.expense.userId));
      },
    );
  }
  
  Future<void> _onUpdateExpense(
    UpdateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final result = await updateExpense(event.expense);
    
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (_) {
        emit(const ExpenseOperationSuccess('Expense updated successfully'));
        add(LoadExpenses(event.expense.userId));
      },
    );
  }
  
  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final result = await deleteExpense(event.id, event.userId);
    
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (_) {
        emit(const ExpenseOperationSuccess('Expense deleted successfully'));
        add(LoadExpenses(event.userId));
      },
    );
  }
  
  Future<void> _onSyncExpenses(
    SyncExpensesEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseSyncing());
    
    final result = await syncExpenses(event.userId);
    
    result.fold(
      (failure) => emit(ExpenseError(failure.message)),
      (_) {
        emit(ExpenseSynced());
        add(LoadExpenses(event.userId));
      },
    );
  }
}
