import 'dart:io';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:game/player.dart';
import 'package:game/position.dart';

class maze_runner extends FlameGame with HasGameRef,HasCollisionDetection{
  @override
  late Player player;

  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(Vector2(1000, 600));
    await images.load('simple.png');
    final level = await TiledComponent.load('maze.tmx', Vector2.all(32));
    add(level);

    var spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('simple.png'),
      columns: 8,
      rows: 6,
    );
    final joystick = JoystickComponent(
      anchor: Anchor.bottomLeft,
      position: Vector2(30, size.y - 30),
      // size: 100,
      background: CircleComponent(
        radius: 60,
        paint: Paint()..color = Colors.black.withOpacity(0.5),
      ),
      knob: CircleComponent(radius: 30),
    );
    add(joystick);

    player = Player(
      joystick: joystick,
      sprite: spriteSheet.getSpriteById(1),
      size: Vector2(64, 64),
      position: gameRef.size / 2,
    );

    player.anchor = Anchor.center;
    add(player);
    var obstaclegroup = level.tileMap.getLayer<ObjectGroup>('platforms');

    for (final obj in obstaclegroup!.objects) {
      final platform = Platform(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height));
      add(platform);
    }
   
  }
}
