extends Node2D  # Herda de Node2D, que é a classe base para nós 2D que não possuem física.

# Referências aos nós usados no script.
@onready var sprite = $"../Personagem/Sprite2D2"  # Referência ao sprite do personagem.
@onready var point_light_2d: PointLight2D = $"../Personagem/PointLight2D"  # Referência à luz pontual 2D, caso precise ser manipulada no futuro.

#################################################
# Funções de interação com diferentes áreas 2D.
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	# Quando o personagem entra na área 2 (denotada como area_2d_2), altera a cor do sprite.
	sprite.modulate = Color(0.118, 0.522, 0.847, 0.176)  # Modifica a cor do sprite para um tom de azul com baixa opacidade.

func _on_area_2d_body_entered(body):
	# Quando o personagem entra em uma área 2 não especificada (geralmente o nome é mais genérico), altera a cor do sprite.
	sprite.modulate = Color(0.424, 0.555, 0.804, 0.145)  # Modifica o sprite para uma cor azul mais suave.

func _on_area_2d_3_body_entered(body):
	# Quando o personagem entra na área 2 (denotada como area_2d_3), altera a cor do sprite.
	sprite.modulate = Color(0.422, 0.503, 0.627, 0.224)  # Modifica o sprite para uma cor mais fria (cinza-azulado).

func _on_area_2d_5_body_entered(body):
	# Quando o personagem entra na área 2 (denotada como area_2d_5), altera a cor do sprite.
	sprite.modulate = Color(0.358, 0.381, 0.494, 0.224)  # Modifica o sprite para um tom de cinza-azulado mais escuro.

func _on_area_2d_7_body_entered(body):
	# Quando o personagem entra na área 2 (denotada como area_2d_7), altera a cor do sprite.
	sprite.modulate = Color(0.278, 0.278, 0.278, 0.224)  # Modifica o sprite para uma cor mais escura, quase preto.

func _on_area_2d_9_body_entered(body):
	# Quando o personagem entra na área 2 (denotada como area_2d_9), altera a cor do sprite.
	sprite.modulate = Color(0.168, 0.168, 0.168, 0.224)  # Modifica a cor para um tom ainda mais escuro de cinza.

func _on_area_2d_10_body_entered(body):
	# Quando o personagem entra na área 2 (denotada como area_2d_10), altera a cor do sprite.
	# Corrige um erro de sintaxe, no qual o valor das cores estava errado.
	sprite.modulate = Color(0.113, 0.113, 0.113, 0.224)  # Modifica a cor para um tom muito escuro de cinza.
####################################################
