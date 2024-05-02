import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/features/wordle/presentation/bloc/wordle_bloc.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  required Color col,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.none,
      duration: const Duration(minutes: 2),
      backgroundColor: col,
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      action: SnackBarAction(
        label: 'Restart',
        textColor: Colors.white,
        onPressed: () => context.read<WordleBloc>().add(WordleRestart()),
      ),
    ),
  );
}
