extends Node2D
#onready var's
@onready var anim = $"Area Navio/AnimationPlayer"
@onready var Bau = $"Area Navio/Bau/Sprite2D"
@onready var bolha = $"Area Navio/bolha"
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
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
