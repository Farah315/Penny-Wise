import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_wise/presentation/bloc/expense_bloc.dart';
import 'package:penny_wise/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDzY4pmq_-JjXnyfFmIGcS7pJY126JGYTU",
      appId: "1:539539449958:android:95e1fa61efd3783cb1a5a7",
      messagingSenderId: "539539449958",
      projectId: "penny-wise-1f30c",
      storageBucket: "penny-wise-1f30c.firebasestorage.app",
    ),
  );

  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);


  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ExpenseBloc>(),
      child: MaterialApp(
        title: 'Penny Wise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: Colors.deepPurple.shade700,
            secondary: Colors.purple.shade400,
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurple.shade700,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple.shade700,
            foregroundColor: Colors.white,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
