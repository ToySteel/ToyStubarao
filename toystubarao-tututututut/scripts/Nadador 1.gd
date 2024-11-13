extends CharacterBody2D
signal Cutscene
@export var dialogue_start: String = "start"
@export var dialogue_resource: DialogueResource
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_de_cutscene_body_entered(body: Node2D) -> void:
	emit_signal("Cutscene")
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)


func _on_hollow_path_cutscene_2() -> void:
	animation_player.set_current_animation("nadano")
