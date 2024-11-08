extends CharacterBody2D
#Onready var's
@onready var actionable_finder = $ActionableFinder
@onready var player = $Sprite2D
@export var speed = 100
@export var rotation_speed = 1.7
@onready var anim = $AnimationPlayer
#var's
var rotation_direction = 0
var direçao = true
var em_dialgo = false
#verificador de direçao movimento
func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed
#processo
func _physics_process(delta):
	#Impedir movimento se estiver em dialogo
	if em_dialgo == false:
		#iniciar dialogos
		if Input.is_action_just_pressed("ui_accept"):
			var actionables = actionable_finder.get_overlapping_areas()
			if actionables.size() > 0:
				actionables[0].action()
				return
		#direçao do movimento
		get_input()
		#rotaçao
		rotation += rotation_direction * rotation_speed * delta 
		#n seim oq isso faz so sei q presisa
		move_and_slide()
		#state_machine para animaçoes
		stade()
		#modificar direçao do player
		if Input.is_action_pressed("ui_up"):
			player.scale.x = 1
			$Colisao.scale.x = 1
			$LightOccluder2D.scale.x = 1
		if Input.is_action_pressed("ui_down"):
			player.scale.x = -1
			$Colisao.scale.x = -1
			$LightOccluder2D.scale.x = -1
#########################################################
#animaçoes
func stade():
	if Input.is_action_just_pressed("ui_up"):
		anim.set_current_animation("Nadano")
	if Input.is_action_just_released("ui_up"):
		anim.set_current_animation("idle")
	if Input.is_action_just_pressed("ui_down"):
		anim.set_current_animation("Nadano")
	if Input.is_action_just_released("ui_down"):
		anim.set_current_animation("idle")
########################################################
#areas 2d
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
