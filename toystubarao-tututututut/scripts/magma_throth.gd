extends Node2D
@onready var personagem = $Personagem
@onready var camera = $Camera
@onready var transition = $transition
@onready var ainma_ao_do_mundo: AnimationPlayer = $"AINMAÇAO DO MUNDO"
@onready var nadador_1: CharacterBody2D = $"Nadador 1"
@export var dialogue_start: String = "start"
@export var dialogue_resource: DialogueResource
signal Pos_conversa
# Called when the node enters the scene tree for the first time.
func _ready():
	personagem.follow_camera(camera)
	transition.des_transition()
	if Globals.Gelo:
		nadador_1.nadano = true
		personagem.em_dialgo = true
		ainma_ao_do_mundo.set_current_animation("nadano 1")
		await ainma_ao_do_mundo.animation_finished
		nadador_1.nadano = false
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "mergulhador_1_Magma_throth")

func _on_pos_conversa() -> void:
	personagem.em_dialgo = false


func _on__body_entered(body: Node2D) -> void:
	if Globals.Gelo:
		nadador_1.nadano = true
		ainma_ao_do_mundo.set_current_animation("nadano 2")
		await ainma_ao_do_mundo.animation_finished
		nadador_1.nadano = false
