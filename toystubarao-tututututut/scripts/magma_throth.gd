extends Node2D
@onready var personagem = $Personagem
@onready var camera = $Camera
@onready var transition = $transition


# Called when the node enters the scene tree for the first time.
func _ready():
	personagem.follow_camera(camera)
	transition.des_transition()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
