extends ColorRect
#seta o paramentro que desejamos modificar no shader's
var Progress = 0.0

func _process(delta):
	material.set("shader_parameter/progress", Progress)
