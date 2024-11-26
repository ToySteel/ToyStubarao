extends CharacterBody2D
@export var nadano = false
@onready var animation_player: AnimationPlayer = $"anima p 3"


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _process(delta: float) -> void:
	if nadano:
		animation_player.set_current_animation("Nadano")
	else:
		animation_player.set_current_animation("idle")
