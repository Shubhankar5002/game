import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'Maingame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final maze_runne = maze_runner();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(
    GameWidget(
      game: maze_runne,
    ),
  );
}
