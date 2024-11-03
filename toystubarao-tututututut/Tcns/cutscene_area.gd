extends Area2D
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
signal Cutscene
#INICIADOR DE CUTSCENE
func _on_body_entered(body):
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	emit_signal("Cutscene")
func _on_cutscene():
	pass # Replace with function body.
