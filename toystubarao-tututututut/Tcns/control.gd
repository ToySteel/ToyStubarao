extends Control
@onready var missoes = $"container/Missoes/Texto Missoes"

func _process(delta):
	missoes.text = str("MISSOES:
" + Globals.Texto_missoes)
