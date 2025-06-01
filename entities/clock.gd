extends StaticBody2D
class_name Clock

## A clock you can collect to increase the time.
##
## yeah

enum Size {SMALL, LARGE}

## The size of the clock.
@export var size: Size = Size.SMALL

func _on_hitbox_collision(body: Node2D) -> void:
	if body is Player:
		get_tree().get_current_scene().time += 1.0 + size as int
		queue_free()
