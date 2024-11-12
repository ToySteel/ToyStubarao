extends CharacterBody2D
signal Cutscene
@export var dialogue_start: String = "start"
@export var dialogue_resource: DialogueResource



func _on_area_de_cutscene_body_entered(body: Node2D) -> void:
	emit_signal("Cutscene")
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
