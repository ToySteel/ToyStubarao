extends CharacterBody2D

@export var speed = 200
@export var rotation_speed = 1.5
@onready var anim = $AnimationPlayer
var rotation_direction = 0
var dir = 1
func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = transform.x * Input.get_axis("ui_end", "ui_up") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	stade()
	if dir = 1:
		if rotation >= deg_to_rad(90):
			#print("aaaaaaaaaaaaaa")
			$Sprite2D.scale.x = -1
		if rotation <= deg_to_rad(-90):
			#print("aaaaaaaaaaaaaa")
			$Sprite2D.scale.x = -1
func stade():
	if Input.is_action_just_pressed("ui_up"):
		anim.set_current_animation("Nadano")
	if Input.is_action_just_released("ui_up"):
		anim.set_current_animation("idle")
