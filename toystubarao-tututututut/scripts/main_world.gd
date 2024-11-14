extends Node2D
@onready var camera_2d: Camera2D = $Camera
@onready var personagem = get_node("Personagem")
@onready var barreira_cutscene: StaticBody2D = $"barreira cutscene"
@onready var static_body_2d_2: StaticBody2D = $StaticBody2D2
@onready var luz_1: Sprite2D = $"Luz 1"
@onready var luz_2: Sprite2D = $"Luz 2"
@onready var luz_3: Sprite2D = $"Luz 3"
@onready var anima_ao_do_mundo: AnimationPlayer = $"ANIMAÇAO DO MUNDO"
@onready var cutscene_area: Area2D = $"Cutscene Area"
@onready var nadador_1: CharacterBody2D = $"Nadador 1"

var things = barreira_cutscene and static_body_2d_2 and luz_1 and luz_2 and luz_3

signal Fim_de_conversa
signal LUZ
signal Inicio_de_conversa_luz
signal Hollow_Path_Pos

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.from_world != null:
		personagem.global_position = get_node(Globals.from_world + "Pos").global_position
	$Personagem.follow_camera(camera_2d)
	print($Personagem)
	if Globals.Game_point == "start":
		pass
	if Globals.Game_point == "Hollow_Path_entered":
		barreira_cutscene.queue_free()
		static_body_2d_2.queue_free()
		luz_1.queue_free()
		luz_2.queue_free()
		luz_3.queue_free()
		cutscene_area.queue_free()
	if Globals.Game_point == "Hollow_Path_Pos":
		barreira_cutscene.queue_free()
		static_body_2d_2.queue_free()
		luz_1.queue_free()
		luz_2.queue_free()
		luz_3.queue_free()
		cutscene_area.queue_free()
		emit_signal("Hollow_Path_Pos")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hollow_path_pos() -> void:
	personagem.em_dialgo = true
	nadador_1.nadano = true
	anima_ao_do_mundo.set_current_animation("nadaçoes")
	await anima_ao_do_mundo.animation_finished
	anima_ao_do_mundo.set_current_animation("Pedra_hollow_path_cai")
	await anima_ao_do_mundo.animation_finished
	Globals.camera.Shake_camera(100)
