import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/core/utils/show_snack_bar.dart';
import 'package:wordle/features/wordle/presentation/bloc/wordle_bloc.dart';
import 'package:wordle/features/wordle/presentation/widgets/board.dart';
import 'package:wordle/features/wordle/presentation/widgets/keyboard.dart';

class WordlePage extends StatelessWidget {
  const WordlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, letterSpacing: 4)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: BlocConsumer<WordleBloc, WordleState>(
        listener: (context, state) {
          if (state is WordleWon) {
            return showSnackBar(
                context: context,
                message: 'You won in ${state.guessedWords.length} tries!',
                col: Theme.of(context).colorScheme.primary);
          }
          if (state is WordleLost) {
            return showSnackBar(
                context: context,
                message: 'You lost! The word was ${state.wantedWord}',
                col: Theme.of(context).colorScheme.error);
          }
        },
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Board(board: state.guessedWords),
            const SizedBox(height: 50),
            state is WordlePlaying
                ? Keyboard(
                    onKeyPressed: (key) =>
                        context.read<WordleBloc>().add(WordleAddLetter(key)),
                    onEnter: () =>
                        context.read<WordleBloc>().add(WordleSubmit()),
                    onDelete: () =>
                        context.read<WordleBloc>().add(WordleDeleteLetter()),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
