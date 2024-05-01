import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/core/entities/word.dart';
import 'package:wordle/features/wordle/presentation/bloc/wordle_bloc.dart';
import 'package:wordle/features/wordle/presentation/widgets/board.dart';
import 'package:wordle/features/wordle/presentation/widgets/keyboard.dart';

class WordlePage extends StatelessWidget {
  const WordlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wordle',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<WordleBloc, WordleState>(
            builder: (context, state) {
              if (state is WordlePlaying) {
                return Board(
                  board: state.guessedWords,
                );
              }

              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 50),
          Keyboard(
            onKeyPressed: (key) =>
                context.read<WordleBloc>().add(WordleAddLetter(key)),
            onEnter: () => context.read<WordleBloc>().add(WordleSubmit()),
            onDelete: () =>
                context.read<WordleBloc>().add(WordleDeleteLetter()),
          )
        ],
      ),
    );
  }
}
