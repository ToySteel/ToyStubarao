extends CharacterBody2D
#Onready var's
@onready var actionable_finder = $ActionableFinder
@onready var player = $nadador
@export var speed = 100
@export var rotation_speed = 1.7
@onready var anim = $"Animation personagem"
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D
@onready var camera: Camera2D = $"../Camera"
@onready var RayLeft: RayCast2D = $RayLeft
@onready var RayRight: RayCast2D = $RayRight


#var's
var rotation_direction = 0
var direçao = true
var em_dialgo = false
var knockback_vector := Vector2.ZERO 
@export var transiçao:bool = false
#verificador de direçao movimento
func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed
#processo
func _physics_process(delta):
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
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
		
		#modificar direçao do player
		if Input.is_action_pressed("ui_up"):
			player.scale.x = 1
			$Colisao.scale.x = 1
			$LightOccluder2D.scale.x = 1
		if Input.is_action_pressed("ui_down"):
			player.scale.x = -1
			$Colisao.scale.x = -1
			$LightOccluder2D.scale.x = -1
		stade()
		move_and_slide()
	#state_machine para animaçoes
	


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
func _on_main_world_fim_de_conversa() -> void:
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
func _on_nadador_1_cutscene() -> void:
	anim.set_current_animation("idle")
	$nadador.frame = 2

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform_2d.remote_path = camera_path

func _on_hollow_path_cutscene_2() -> void:
	player.scale.x = -1
	$Colisao.scale.x = -1
	$LightOccluder2D.scale.x = -1
	anim.set_current_animation("Nadano")

func die(knockback_force := Vector2.ZERO, duration := 0.25):
	if knockback_force != Vector2.ZERO:
		em_dialgo = true
		rotation = 0
		camera.Shake_camera(100, 0.8, 40)
		knockback_vector = knockback_force
		var knockback_tween: Tween = get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		camera.Shake_camera(100, 0.2, 60)
		anim.set_current_animation("Morte")
		camera.Shake_camera(100, 0.8,80)
		await anim.animation_finished
		var transition = get_parent().get_node("transition")
		transition.transition()
		camera.Shake_camera(100, 0.8,60)
		await transition.transition()
		if Globals.Checkpoints != null:
			self.global_position = get_parent().get_node(Globals.Checkpoints).global_position
		recreate()
		transition.des_transition()
func died():
	if RayLeft.is_colliding():
		die(Vector2(1000,-1000))
	if RayRight.is_colliding():
		die(Vector2(-1000,-1000))
func recreate():
	em_dialgo = false
	anim.set_current_animation("idle")
