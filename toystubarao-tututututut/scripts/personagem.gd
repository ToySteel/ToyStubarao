extends CharacterBody2D
@onready var actionable_finder = $ActionableFinder
@onready var player = $Sprite2D
@export var speed = 100
@export var rotation_speed = 1.7
@onready var anim = $AnimationPlayer
@onready var remote_transform := $remote as RemoteTransform2D

var rotation_direction = 0
var direçao = true
var em_dialgo = false

func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed

func _physics_process(delta):
	if em_dialgo == false:
		if Input.is_action_just_pressed("ui_accept"):
			var actionables = actionable_finder.get_overlapping_areas()
			if actionables.size() > 0:
				actionables[0].action()
				return
		get_input()
		rotation += rotation_direction * rotation_speed * delta 
		move_and_slide()
		stade()
		if Input.is_action_pressed("ui_up"):
			player.scale.x = 1
			$Colisao.scale.x = 1
			$LightOccluder2D.scale.x = 1
		if Input.is_action_pressed("ui_down"):
			player.scale.x = -1
			$Colisao.scale.x = -1
			$LightOccluder2D.scale.x = -1
func stade():
	if Input.is_action_just_pressed("ui_up"):
		anim.set_current_animation("Nadano")
	if Input.is_action_just_released("ui_up"):
		anim.set_current_animation("idle")
	if Input.is_action_just_pressed("ui_down"):
		anim.set_current_animation("Nadano")
	if Input.is_action_just_released("ui_down"):
		anim.set_current_animation("idle")
		
func _on_static_body_2d_holograma_conversas():
	em_dialgo = true
func _on_word_tutubarao_fim_de_conversa():
	em_dialgo = false
	Globals.Missoes += 1
func _on_cutscene_area_cutscene():
	anim.set_current_animation("Cima ou baixo")
	position.x == 3527
	position.y == 12382
	em_dialgo = true
func _on_cutscene_area_fim_de_cutscene():
	em_dialgo = false
	Globals.Missoes += 1
