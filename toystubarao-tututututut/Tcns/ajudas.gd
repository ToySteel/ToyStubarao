extends StaticBody2D
@onready var anim = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func State():
	var state = "Start"
	
	if anim != state:
		anim.play = state
