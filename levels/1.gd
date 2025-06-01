extends Node2D
class_name Menu

## 1
##
## 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"): get_tree().change_scene_to_file("res://levels/2.tscn")
