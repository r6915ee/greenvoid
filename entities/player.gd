extends CharacterBody2D
class_name Player

## The player themself.
##
## This is pretty self-explanatory.

enum PlayerState {
	NORMAL,
	BOUNCE,
	DASHING,
	FREE,
	AIRBORNE,
	STUNNED
}

## The player's current speed.
var speed: float = 0
## The player's current falling speed.
var falling_speed: float = 0
## The player's current state.
var state: PlayerState = PlayerState.NORMAL
## Whether or not the player is currently immune.
var immune: bool = false
## How much time is left before leaving the dash state.
var dash_time: float = 0.2
## How many chain actions are left to be used.
var chain_actions: int = 3

## How far the camera can go right, in tiles.
@export var camera_limit: int = 32

func _ready() -> void:
	$Camera.limit_right = camera_limit * 16

func _physics_process(delta: float) -> void:
	if state != PlayerState.STUNNED and state != PlayerState.DASHING: speed += delta * 700 * (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	speed *= 0.9
	
	match state:
		PlayerState.NORMAL:
			falling_speed += delta * 600
			if is_on_floor() or is_on_ceiling(): falling_speed = 0
			if is_on_ceiling(): position.y += 1
			if Input.is_action_just_pressed("ui_accept"):
				if is_on_floor(): falling_speed = -200
				elif Input.is_action_pressed("ui_down"):
					falling_speed = 600
					$Sprite/Afterimages.emitting = true
					#$Anim.play("bounce")
					state = PlayerState.BOUNCE
				else:
					speed = 700 * (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
					dash_time = 0.2
					$Sprite/Afterimages.emitting = true
					state = PlayerState.DASHING
		PlayerState.BOUNCE:
			falling_speed += delta * 600
			if is_on_floor():
				falling_speed = -320
				$Sprite/Afterimages.emitting = false
				$Anim.play("RESET")
				state = PlayerState.AIRBORNE
		PlayerState.DASHING:
			falling_speed = 0
			dash_time -= delta
			if not dash_time > 0:
				$Sprite/Afterimages.emitting = false
				state = PlayerState.AIRBORNE
		PlayerState.AIRBORNE:
			falling_speed += delta * 600
			if is_on_floor():
				chain_actions = 3
				state = PlayerState.NORMAL
			if is_on_ceiling():
				falling_speed = 0
				position.y += 1
			if Input.is_action_just_pressed("ui_accept"):
				if Input.is_action_pressed("ui_down") and chain_actions > 0:
					falling_speed = 600
					$Sprite/Afterimages.emitting = true
					chain_actions -= 1
					#$Anim.play("bounce")
					state = PlayerState.BOUNCE
				elif (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and chain_actions > 0:
					speed = 450 * (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
					dash_time = 0.01
					chain_actions -= 1
					$Sprite/Afterimages.emitting = true
					state = PlayerState.DASHING
				elif chain_actions > 0:
					falling_speed = -150
					chain_actions -= 1
					state = PlayerState.AIRBORNE
		PlayerState.STUNNED:
			falling_speed += delta * 600
			if is_on_floor(): falling_speed = 0
	
	velocity.x = speed
	velocity.y = falling_speed
	
	move_and_slide()
