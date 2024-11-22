extends CanvasModulate

# Carrega o nó 'CanvasModulate' para modificar as propriedades do próprio nó.
@onready var canvas_modulate = $"."  # O uso de $"." referencia o próprio nó atual.

# Função chamada quando o nó entra na árvore da cena pela primeira vez.
func _ready():
	# A linha abaixo parece incompleta ou incorreta.
	# Pode ter a intenção de definir alguma propriedade de cor, mas atualmente não faz nada.
	"color"  # Parece que deveria haver algum código aqui para modificar a cor.

# Função chamada a cada frame. O 'delta' é o tempo decorrido desde o último frame.
func _process(delta):
	# Atualmente, não há nenhum comportamento definido para cada frame.
	pass
