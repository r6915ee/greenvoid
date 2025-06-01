extends StaticBody2D
class_name Lift

## When in collision with a lift, the player will begin rising.
##
## Yeah.

## A reference to the player node.
var player: Player
## Whether or not the player is being lifted by... well, a lift.
var lifting: bool = false

func _physics_process(delta: float) -> void: if lifting and player != null: player.falling_speed -= delta * 450
func _on_hitbox_collision(body: Node2D) -> void: if body is Player:
	player = body
	player.position.y -= 1
	lifting = true
func _on_hitbox_leave(body: Node2D) -> void: if body is Player:
	player = null
	lifting = false
