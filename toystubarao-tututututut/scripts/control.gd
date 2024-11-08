extends Control
#programaçao da missao atual no canvas
@onready var missoes = $"container/Missoes/Texto Missoes"

func _process(delta):
	missoes.text = str("MISSOES:
" + Globals.Texto_missoes)
