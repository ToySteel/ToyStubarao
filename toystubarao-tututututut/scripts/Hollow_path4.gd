extends Node2D
#onready var's
@onready var anim = $"Area Navio/AnimationPlayer" as AnimationPlayer
@onready var Bau = $"Area Navio/Bau/Sprite2D" as Sprite2D
@onready var bolha = $"Area Navio/bolha" as Area2D
@onready var personagem = $Personagem as CharacterBody2D
@onready var transition = $transition as CanvasLayer
@onready var anima_mundo = $"animaçao do mundo" as AnimationPlayer
@onready var light_occluder_2d = $Mato/LightOccluder2D as LightOccluder2D
@onready var porta = $porta as StaticBody2D
@onready var anima_porta = $porta/AnimatedSprite2D as AnimatedSprite2D
@onready var ligh_porta = $porta/LightOccluder2D as LightOccluder2D
@onready var camera = $Camera2D as Camera2D
@onready var anima_world = $"animaçao do mundo" as AnimationPlayer

#Export var's
@export var path = "res://Tcns/Main_world.tscn"
@export var dialogue_start: String = "start"
@export var dialogue_resource: DialogueResource

#var's
var cutscene = false

#Singal's
signal Inicio_de_conversa_luz
signal cutscene2

#iniciar transiçao ao entrar na faze
func _ready() -> void:
	if cutscene == false:
		personagem.follow_camera(camera)
	transition.des_transition()
#nao faz nada
func _process(delta: float) -> void:
	pass
###################################################################
#animaçao da area do navio
func _on_bau_body_entered(body: Node2D) -> void:
	Bau.frame = 1
	Globals.chave_hollow_path = true
func _on_bolha_body_entered(body: Node2D) -> void:
	anim.set_current_animation("Bolha estoura")
	bolha.queue_free()
#######################################################################
#transiçoes
func _on_caverna_body_entered(body):
	transition.change_scene(false ,path, 1778, 2107)
func _on_saida_da_caverna_body_entered(body):
	transition.change_scene(false ,path, 13918, 2531)
#################################################################################
#mato
func _on_mato_body_entered(body: Node2D) -> void:
	light_occluder_2d.visible = false
	anima_mundo.set_current_animation("mato sumindo")
func _on_mato_body_exited(body: Node2D) -> void:
	anima_mundo.set_current_animation("mato aparecendo")
	await anima_mundo.animation_finished
	light_occluder_2d.visible = true
###################################################################################
#porta
func _on_actionable_body_entered(body):
	if Globals.chave_hollow_path == true:
		ligh_porta.visible = false
		anima_porta.play("porta explodindo")
		await anima_porta.animation_finished
		porta.queue_free() 
#######################################################################################
#cutscene
func _on_nadador_1_cutscene() -> void:
	anima_world.set_current_animation("piscano")
	personagem.global_position = $Marker2D.global_position
	personagem.rotation = 0
	personagem.em_dialgo = true
func _on_inicio_de_conversa_luz() -> void:
	anima_world.set_current_animation("conversa_luz")
	await anima_world.animation_finished
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
func _on_cutscene_2() -> void:
	cutscene = true
	anima_world.set_current_animation("ANDAR")
	$Timer.start()
func _on_timer_timeout() -> void:
	Globals.from_world = name
	transition.change_scene(true ,path, "no", "no")
####################################################################################
#
