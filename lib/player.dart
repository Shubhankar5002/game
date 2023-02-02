import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Maingame.dart';

class Player extends SpriteComponent with HasGameRef<maze_runner> {
  Vector2 moveDirection = Vector2.zero();
  JoystickComponent joystick;
  double speed = 300;
  Player({
    required this.joystick,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  Vector2 keyboardDelta = Vector2.zero();
  static final _keysWatched = {
    LogicalKeyboardKey.keyW,
    LogicalKeyboardKey.keyA,
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.keyD,
    LogicalKeyboardKey.space,
  };

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Set this to zero first - if the user releases all keys pressed, then
    // the set will be empty and our vector non-zero.
    keyboardDelta.setZero();

    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      keyboardDelta.y = -1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      keyboardDelta.x = -1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      keyboardDelta.y = 1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      keyboardDelta.x = 1;
    }

    // Handled keyboard input
    return false;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!keyboardDelta.isZero()) {
      position.add(keyboardDelta * speed * dt);
    }
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * speed * dt);
    }

    // Clamp position of player such that the player sprite does not go outside the screen size.
    position.clamp(
      Vector2.zero() + size / 2,
      gameRef.size - size / 2,
    );
    add(CircleHitbox());
  }
}

