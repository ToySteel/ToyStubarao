extends Area2D

@onready var timer_ativo = $"Timer ativo"
@onready var timer_desativo = $"Timer desativo"

@onready var anim = $aniamtion
@onready var colision = $colision

@export var Jorravel = false

var state = "Jorrando"
func _ready():
	timer_desativo.start()

func _process(delta):
	_state()
func _on_body_entered(body):
	print("MORREU")
 
func _state():
	if anim.name != state:
		anim.play(state)
 
func desativar():
	colision.disabled = true
	state = "Desligado"
	Jorravel = false

func _on_timer_ativo_timeout():
	if Jorravel:
		state = "Jorrando"
		colision.disabled = false
		timer_desativo.start()
func _on_timer_desativo_timeout():
	if Jorravel:
		state = "Ligado"
		colision.disabled = true
		timer_ativo.start()
