extends CharacterBody2D
signal Cutscene
@export var dialogue_start: String = "start"
@export var dialogue_resource: DialogueResource
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var nadano = false


func _ready() -> void:
	if nadano == true:
		animation_player.set_current_animation("nadano")
	else:
		animation_player.set_current_animation("Idle")
func _on_area_de_cutscene_body_entered(body: Node2D) -> void:
	if Globals.Game_point != "Hollow_Path_Pos":
		emit_signal("Cutscene")
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)


func _on_hollow_path_cutscene_2() -> void:
	animation_player.set_current_animation("nadano")
	if animation_player.name == "nadaçoes":
		await animation_player.animation_finished
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
