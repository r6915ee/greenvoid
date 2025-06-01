extends StaticBody2D
class_name Spike

## Spikes...are time damaging! Yeah!
##
## Spikes, while not looking like real spikes, drain your time if you are in contact with them.
## Avoid them at all costs.

## Whether or not the timer is being damaged by a spike.
var damage_timer: bool = false

func _process(delta: float) -> void: if damage_timer: get_tree().current_scene.time -= delta * 2

func _on_hitbox_collision(body: Node2D) -> void: if body is Player: damage_timer = true
func _on_hitbox_leave(body: Node2D) -> void: if body is Player: damage_timer = false
