extends Area2D
#Onready var's
@onready var animation = $animation
@onready var colision = $colision
@onready var dangers = $"../../dangers"
#var's
var state = "Normal"

#verificar a animaçao atual a cada processo
func _process(delta):
	_state()
#verificador de animaçao atual
func _state():
	if animation.name != state:
		animation.play(state)
#verificador de colisao
func _on_body_entered(body):
	#modificador de estado da animaçao
	state = "ice"
	#dangers.get_child(tentativa)
	#envia sinal para desativar a area perigosa adjacnte
	print(get_parent().get_node("L" + name))
	get_parent().get_node("L" + name).desativar()

	
