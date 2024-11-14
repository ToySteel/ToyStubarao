extends Camera2D
@onready var timer: Timer = $Timer
@onready var tween:Tween = get_tree().create_tween()
var shake_amount = 0
var initial_offset = 0
var default_offset = 5
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	set_process(false)
	Globals.camera = self
func _process(delta: float) -> void:
	offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(shake_amount, -shake_amount))
func Shake_camera(new_shake, shake_time = 0.4, shake_limit = 20):
	set_process(true)
	shake_amount += new_shake
	
	if shake_amount > shake_limit:
		shake_amount = shake_limit
	
	timer.wait_time = shake_time
	timer.start()

func _on_timer_timeout() -> void:
	set_process(false)
	shake_amount = 0.0
	offset.x = 0
	offset.y = 0
	tween.tween_property(self, "offset", initial_offset, default_offset)
	tween.play()
#, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT
