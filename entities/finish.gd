extends StaticBody2D
class_name Finish

## When in collision with a finish block, the player is transported to the next scene.
##
## Yeah.

func _on_hitbox_collision(body: Node2D) -> void: if body is Player: get_tree().current_scene._switch_level()
