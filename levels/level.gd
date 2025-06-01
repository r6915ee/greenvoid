extends Node2D
class_name Level

## The actual code for a generic level.
##
## The brief description says it all.

## The time left.
@export var time: float = 11.0
## Whether or not the gameplay is active.
var active: bool = true
## The scene to switch to when beating the level.
@export var next_scene: PackedScene = preload("res://levels/2.tscn")

func _process(delta: float) -> void:
	if active:
		time -= delta
		if time <= 0: get_tree().reload_current_scene()
		$HUD/Timer.text = str(floori(time))

func _switch_level() -> void:
	get_tree().change_scene_to_packed.call_deferred(next_scene)
