extends Node2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var Bau: Sprite2D = $Bau/Sprite2D
@onready var bolha: Area2D = $bolha

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_bau_body_entered(body: Node2D) -> void:
	Bau.frame = 1
func _on_bolha_body_entered(body: Node2D) -> void:
	anim.set_current_animation("Bolha estoura")
	bolha.queue_free()
