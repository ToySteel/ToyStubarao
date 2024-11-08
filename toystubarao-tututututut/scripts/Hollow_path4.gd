extends Node2D
#onready var's
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var Bau: Sprite2D = $Bau/Sprite2D
@onready var bolha: Area2D = $bolha
@onready var personagem = $Personagem
@onready var transition = $transition
@export var path = ""
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
func _on_bolha_body_entered(body: Node2D) -> void:
	anim.set_current_animation("Bolha estoura")
	bolha.queue_free()
#######################################################################
#transiçoes
func _on_caverna_body_entered(body):
	transition.change_scene(false ,path, 1778, 2107)
func _on_saida_da_caverna_body_entered(body):
	transition.change_scene(false ,path, 13918, 2531)
func _on_area_principal_body_entered(body: Node2D) -> void:
	Globals.from_world = get_parent().name
	transition.change_scene(true ,path, 1691, 12128)
