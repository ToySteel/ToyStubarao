extends Node2D
@onready var personagem = $Personagem
@onready var camera = $Camera
@onready var transition = $transition
@onready var ainma_ao_do_mundo: AnimationPlayer = $"AINMAÇAO DO MUNDO"
@onready var nadador_1: CharacterBody2D = $"Nadador 1"
@onready var utilitarios: Node2D = $Utilitarios

@export var dialogue_start: String = "start"
@export var dialogue_resource: DialogueResource
signal Pos_conversa
# Called when the node enters the scene tree for the first time.
func _ready():
	scene_restart()
	personagem.follow_camera(camera)
	transition.des_transition()
	Globals.camera = camera
	if Globals.Gelo:
		nadador_1.nadano = true
		personagem.em_dialgo = true
		ainma_ao_do_mundo.set_current_animation("nadano 1")
		await ainma_ao_do_mundo.animation_finished
		nadador_1.nadano = false
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "mergulhador_1_Magma_throth")
		print(get_node(Globals.Checkpoints))

func _on_pos_conversa() -> void:
	personagem.em_dialgo = false


#func _on__body_entered(body: Node2D) -> void:
	#if Globals.Gelo:
		#nadador_1.nadano = true
		#ainma_ao_do_mundo.set_current_animation("nadano 2")
		#await ainma_ao_do_mundo.animation_finished
		#nadador_1.nadano = false


func scene_restart():
	var Checkpoint_singleton = Globals.Checkpoints
	var checkpoint_atual = get_node(Checkpoint_singleton)
	print(checkpoint_atual)
	print(checkpoint_atual.global_position)
	print(personagem.global_position)
	#if checkpoint_atual != null or !Marker2D:
		#personagem.global_position = checkpoint_atual.global_position
		#print(personagem.global_position)
	if Checkpoint_singleton != "0":
		if Checkpoint_singleton == "1":
			desativar_lava("1")
		if Checkpoint_singleton == "2":
			desativar_lava("1")
			desativar_lava("2")
		if Checkpoint_singleton == "3":
			desativar_lava("1")
			desativar_lava("2")
			desativar_lava("3")
		if Checkpoint_singleton == "4":
			desativar_lava("1")
			desativar_lava("2")
			desativar_lava("3")
			desativar_lava("4")
func desativar_lava(number: String):
	var lava_atual = utilitarios.get_node(number).body_entered()
	return lava_atual
