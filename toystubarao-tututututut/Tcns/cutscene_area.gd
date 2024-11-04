extends Area2D
signal Fim_de_cutscene
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@onready var anima: AnimationPlayer = $"../ANIMAÇAO DO MUNDO"
signal Cutscene
#INICIADOR DE CUTSCENE
func _on_body_entered(body):
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	emit_signal("Cutscene")
func _on_cutscene():
	pass # Replace with function body.

func _on_word_tutubarao_luz() -> void:
	anima.set_current_animation("CUTSCENE")


func _on_animaçao_do_mundo_animation_finished(anim_name):
	emit_signal("Fim_de_cutscene")
	queue_free()
