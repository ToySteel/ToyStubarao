extends Node2D
@onready var personagem = $Personagem
signal Fim_de_conversa
signal LUZ

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.from_world != null:
		personagem.global_position = get_node(Globals.from_world + "Pos").global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
