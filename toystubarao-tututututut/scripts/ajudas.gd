extends Area2D

# Carrega a animação associada ao nó AnimatedSprite2D2 assim que o nó é carregado.
@onready var anim = $AnimatedSprite2D2

# Carrega o nó StaticBody2D2 assim que o nó é carregado.
@onready var static_body_2d_2: StaticBody2D = $"../StaticBody2D2"

# Variável exportada para o editor que contém o recurso de diálogo, armazenando os dados do diálogo a serem exibidos.
@export var dialogue_resource: DialogueResource

# Variável exportada para o editor que define o ponto de partida do diálogo, geralmente identificada por uma chave ou string.
@export var dialogue_start: String = "start"

# Variável que mantém o estado atual da animação ou da lógica associada.
var state = "Start"

# Sinal que será emitido quando ocorrer uma interação específica.
signal Holograma_conversas


# Função que é chamada para executar uma ação específica, neste caso, mostrar um balão de diálogo.
func action() -> void:
	# Mostra o balão de diálogo usando o recurso de diálogo e a chave de início.
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	
	# Emite o sinal "Holograma_conversas" para indicar que uma conversa foi iniciada.
	emit_signal("Holograma_conversas")
	
	# Remove o StaticBody2D2 da cena.
	static_body_2d_2.queue_free()

# Função que é executada a cada frame, usada para atualizar o estado do objeto.
func _process(delta):
	# Atualiza o estado da animação com base nas mudanças de estado.
	_set_state()
	pass

# Função para definir o estado da animação, verificando se o estado atual é diferente do nome da animação.
func _set_state():
	if anim.name != state:
		# Reproduz a animação correspondente ao estado atual.
		anim.play(state)

# Callback chamado quando um corpo (body) entra na área deste objeto.
func _on_body_entered(body):
	# Muda o estado para "ligando" ao detectar um corpo entrando.
	state = "ligando"

# Callback chamado quando a animação do AnimatedSprite2D2 é finalizada.
func _on_animated_sprite_2d_2_animation_finished():
	# Se a animação finalizada estava no estado "ligando", muda o estado para "Ligado".
	if state == "ligando":
		state = "Ligado"
	
	# Se a animação finalizada estava no estado "desligando", muda o estado para "Start".
	if state == "desligando":
		state = "Start"

# Callback chamado quando um corpo (body) sai da área deste objeto.
func _on_body_exited(body):
	# Muda o estado para "desligando" ao detectar um corpo saindo.
	state = "desligando"
