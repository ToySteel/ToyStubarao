extends Area2D
#onready var's
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@onready var barreira_cutscene: StaticBody2D = $"../barreira cutscene"
@onready var anima: AnimationPlayer = $"../ANIMAÇAO DO MUNDO"

#var's



#signal's
signal Cutscene
signal Fim_de_cutscene
#INICIADOR DE CUTSCENE
func _on_body_entered(body):
	$"../Personagem".position.x == 3527
	$"../Personagem".position.y == 12382
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	emit_signal("Cutscene")
func _on_cutscene():
	pass # Replace with function body.


func _on_main_world_luz() -> void:
	anima.set_current_animation("CUTSCENE")
	await anima.animation_finished
	emit_signal("Fim_de_cutscene")
	barreira_cutscene.queue_free()
	queue_free()
##fim de cutscene
#func _on_animaçao_do_mundo_animation_finished(anim_name):
	#emit_signal("Fim_de_cutscene")
	#queue_free()
