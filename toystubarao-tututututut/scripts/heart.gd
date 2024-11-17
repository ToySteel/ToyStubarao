extends Area2D
@onready var animation = $animation

@onready var colision = $colision
@export var magma_type = ""
var state = "Normal"
var tentativa = name
func _process(delta):
	_state()
func _on_body_entered(body):
	state = "ice"
	get_parent().get_parent().get
	print(get_parent().get_parent().name)
func _state():
	if animation.name != state:
		animation.play(state)
	
