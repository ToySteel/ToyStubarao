extends Node2D
#onready var's
@onready var anim = $"Area Navio/AnimationPlayer"
@onready var Bau = $"Area Navio/Bau/Sprite2D"
@onready var bolha = $"Area Navio/bolha"
@onready var personagem = $Personagem
@onready var transition = $transition
@export var path = ""
@onready var anima_mundo = $"animaçao do mundo"
@onready var light_occluder_2d = $Mato/LightOccluder2D
@onready var porta = $porta
@onready var anima_porta = $porta/AnimatedSprite2D
@onready var ligh_porta = $porta/LightOccluder2D

#iniciar transiçao ao entrar na faze
func _ready() -> void:
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
	personagem.global_position = $Marker2D.global_position
	personagem.rotation = 0
	personagem.em_dialgo = true
																																																																																																																																																																																																																																																																			 
