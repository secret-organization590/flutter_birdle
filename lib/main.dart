import 'package:flutter/material.dart';
import 'package:flutter_birdle/game.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Tile('A', .hit),
              Tile('B', .partial),
              Tile('C', .miss),
              Tile('D', .none),
            ],
          ),
        ),
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
