extends  Area2D
var state = "Start"
@onready var anim = $AnimatedSprite2D2
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
signal Holograma_conversas


func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	emit_signal("Holograma_conversas")
func _process(delta):
	_set_state()
	pass
func _set_state():
	if anim.name != state:
		anim.play(state)
func _on_body_entered(body):
	state = "ligando"
func _on_animated_sprite_2d_2_animation_finished():
	if state == "ligando":
		state = "Ligado"
	if state == "desligando":
		state = "Start"
func _on_body_exited(body):
	state = "desligando"
