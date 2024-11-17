extends Area2D
@onready var anim = $aniamtion
@onready var colision = $colision

@export var magma_type = ""

var state = "Jorrando"
func _process(delta):
	_state()
func _on_body_entered(body):
	print("MORREU")
 
func _state():
	if anim.name != state:
		anim.play(state)
 

#se receber sinal DESLIGANDO desligar
#se a variavel export magma type for Ocasional Timer.start
