extends Area2D
#Onready var's
@onready var animation = $animation
@onready var colision = $colision
@onready var Luz: PointLight2D = $PointLight2D
@onready var dangers = $"../../dangers"
#var's
var state = "Normal"
@export var AND = "Normal"
#verificar a animaçao atual a cada processo
func _process(delta):
	_state()
#verificador de animaçao atual
func _state():
	if animation.name != state:
		animation.play(state)
#verificador de colisao
func _on_body_entered(body):
	if Globals.Gelo:
		
		lava_adjacente()
		#modificador de estado da animaçao
		state = "ice"
		Luz.color = Color(0.498, 0.921, 1)
		#dangers.get_child(tentativa)
		#envia sinal para desativar a area perigosa adjacnte
		print(lava_adjacente())
		if lava_adjacente() != null:
			lava_adjacente().desativar() == OK
		if AND == "Cu_na_terra":
			$"../L3_3".desativar()
			$"../L4_3".desativar()
		if AND == "Butao_na_terra":
			$"../L5_4".desativar()
			$"../L6_4".desativar()
			$"../L7_4".desativar()
			$"../L8_4".desativar()
			$"../L9_4".desativar()
func lava_adjacente():
	var lava = get_parent().get_node("L" + name)
	return lava
