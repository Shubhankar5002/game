import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game/player.dart';

class Platform extends PositionComponent with CollisionCallbacks{
  late ShapeHitbox hitbox;
  Platform({
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    super.children,
    super.priority,
  }) : super(
    position: position,
    size: size,
    scale: scale,
    anchor: anchor,
    angle: angle,
  ){
    debugMode=true;
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player){
      
    }
    super.onCollision(intersectionPoints, other);
  }
}
