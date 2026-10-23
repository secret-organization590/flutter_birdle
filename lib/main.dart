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

class GamePage extends StatelessWidget {
  final Game _game = Game();

  GamePage({super.key});

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
              children: [
                for (final letter in guess) Tile(letter.char, letter.type),
              ],
            ),
        ],
      ),
    );
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
