import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/features/wordle/presentation/bloc/wordle_bloc.dart';
import 'package:wordle/features/wordle/presentation/pages/wordle_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle App',
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        brightness: Brightness.dark,
        useMaterial3: true,
      ).copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.redAccent.shade400),
      ),
      home: BlocProvider<WordleBloc>(
        create: (context) => WordleBloc(),
        child: const WordlePage(),
      ),
    );
  }
}
