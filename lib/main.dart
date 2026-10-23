import 'package:flutter/material.dart';
import 'package:flutter_birdle/game.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Align(alignment: .center, child: Text('Birdle')),
        ),
        body: Center(child: GamePage()),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          for (final guess in _game.guesses)
            Row(
              spacing: 5.0,
              mainAxisAlignment: .center,
              children: [
                for (final letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.5,
                      vertical: 2.5,
                    ),
                    child: Tile(letter.char, letter.type),
                  ),
              ],
            ),
          GuessInput(
            onSumbitGuess: (guess) {
              setState(() {
                _game.guess(guess);
              });
            },
          ),
        ],
      ),
    );
  }
}

class GuessInput extends StatefulWidget {
  final void Function(String) onSumbitGuess;

  const GuessInput({super.key, required this.onSumbitGuess});

  @override
  State<GuessInput> createState() => _GuessInputState();
}

class _GuessInputState extends State<GuessInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              autofocus: true,
              focusNode: _focusNode,
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: _textEditingController,
              onSubmitted: (value) {
                _onSubmit();
              },
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_circle_up),
          onPressed: _onSubmit,
        ),
      ],
    );
  }

  void _onSubmit() {
    widget.onSumbitGuess(_textEditingController.text.trim());

    _textEditingController.clear();
    _focusNode.requestFocus();
  }
}

class Tile extends StatelessWidget {
  final String letter;
  final HitType hitType;

  const Tile(this.letter, this.hitType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        border: .all(color: Colors.grey.shade300),
        color: getHitColor(),
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  Color getHitColor() {
    return switch (hitType) {
      .hit => Colors.green,
      .partial => Colors.yellow,
      .miss => Colors.grey,

      _ => Colors.white,
    };
  }
}
