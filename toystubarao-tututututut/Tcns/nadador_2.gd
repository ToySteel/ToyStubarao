extends CharacterBody2D
@onready var personagem: CharacterBody2D = $"../Personagem"
@export var dialogue_resource: DialogueResource  # Recurso de diálogo
@export var nadano = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	if nadano:
		animation_player.set_current_animation("nadano")
	else:
		animation_player.set_current_animation("Idle")
