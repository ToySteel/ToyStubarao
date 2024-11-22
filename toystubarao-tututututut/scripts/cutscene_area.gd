extends Area2D

# Variáveis exportadas e de inicialização.
# Carrega o recurso de diálogo utilizado na cutscene.
@export var dialogue_resource: DialogueResource

# Define o ponto de início do diálogo.
@export var dialogue_start: String = "start"

# Referências para os nós relacionados à cutscene.
@onready var barreira_cutscene: StaticBody2D = $"../barreira cutscene"  # Barreira que bloqueia o personagem durante a cutscene.
@onready var anima: AnimationPlayer = $"../ANIMAÇAO DO MUNDO"  # Controlador de animações.

# Declaração dos sinais usados.
signal Cutscene  # Sinal emitido quando a cutscene começa.
signal Fim_de_cutscene  # Sinal emitido quando a cutscene termina.

# Função que é chamada quando o corpo entra na área (trigger para iniciar a cutscene).
func _on_body_entered(body):
	# Verifica se o personagem está na posição específica que ativa a cutscene.
	$"../Personagem".position.x == 3527
	$"../Personagem".position.y == 12382
	
	# Mostra o balão de diálogo utilizando o recurso de diálogo definido.
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	
	# Emite o sinal indicando que a cutscene começou.
	emit_signal("Cutscene")

# Função de callback para quando o sinal "Cutscene" é emitido.
# Atualmente, não faz nada. Você pode implementar a lógica desejada aqui.
func _on_cutscene():
	pass  # Substitua com a lógica desejada para quando a cutscene iniciar.

# Função que lida com a luz principal no mundo, ativando a animação de cutscene.
func _on_main_world_luz() -> void:
	# Define a animação atual para "CUTSCENE".
	anima.set_current_animation("CUTSCENE")
	
	# Aguarda o término da animação antes de continuar.
	await anima.animation_finished
	
	# Emite o sinal indicando que a cutscene terminou.
	emit_signal("Fim_de_cutscene")
	
	# Remove a barreira que bloqueava o personagem.
	barreira_cutscene.queue_free()
	
	# Remove o nó atual, finalizando a cutscene.
	queue_free()

# Função comentada que seria chamada quando a animação do mundo terminasse.
# func _on_animaçao_do_mundo_animation_finished(anim_name):
#	emit_signal("Fim_de_cutscene")  # Emite o sinal de fim da cutscene.
#	queue_free()  # Remove o nó atual.
