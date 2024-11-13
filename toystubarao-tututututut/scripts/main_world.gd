extends Node2D
@onready var camera_2d: Camera2D = $Camera
@onready var personagem = get_node("Personagem")



signal Fim_de_conversa
signal LUZ
signal Inicio_de_conversa_luz

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.from_world != null:
		personagem.global_position = get_node(Globals.from_world + "Pos").global_position
	#$Personagem.follow_camera(camera_2d)
	print($Personagem)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
