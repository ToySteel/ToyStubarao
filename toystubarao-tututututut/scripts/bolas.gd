extends Path2D

# Carrega os nós 'PathFollow2D' que representam as bolas que seguem o caminho.
@onready var Bola1: PathFollow2D = get_node("Bola1")
@onready var Bola2: PathFollow2D = get_node("Bola2")
@onready var Bola3: PathFollow2D = get_node("Bola3")

# Variável para controlar se as bolas devem girar ou não.
var girando: bool = true

# Velocidade de rotação das bolas, exportada para poder ser ajustada no editor.
@export var velocity: float = 3.5

# Função chamada a cada frame para atualizar o estado das bolas.
func _process(delta: float) -> void:
	# Verifica se Bola1 existe e chama a função para girar as bolas, passando "1" como identificação.
	if Bola1 != null:
		Bolas_girando(Bola1, "1") == OK
	
	# Verifica se Bola2 existe e chama a função para girar as bolas, passando "2" como identificação.
	if Bola2 != null:
		Bolas_girando(Bola2, "2") == OK
	
	# Verifica se Bola3 existe e chama a função para girar as bolas, passando "3" como identificação.
	if Bola3 != null:
		Bolas_girando(Bola3, "3") == OK

# Função que controla a rotação ou desativação das bolas.
func Bolas_girando(Bola: PathFollow2D, numeraçao: String):
	# Se a variável 'girando' for verdadeira, cria uma animação para girar a bola.
	if girando:
		# Cria um objeto Tween para animar a propriedade 'progress_ratio' da bola.
		var bolas_girando: Tween = get_tree().create_tween()
		# Anima a propriedade 'progress_ratio' para fazer a bola girar ao longo do caminho.
		bolas_girando.tween_property(Bola, "progress_ratio", -1, velocity).from(get_Bola(Bola))
	else:
		# Se 'girando' for falsa, desativa a bola correspondente.
		# Acessa a bola específica com base no número fornecido.
		var Bola_em_questao: Area2D = get_node("Bola" + numeraçao).get_node("Bola")
		
		# Desativa a colisão da bola.
		var colisao_bola: CollisionShape2D = Bola_em_questao.get_node("colision")
		colisao_bola.disabled = true
		
		# Torna a animação da bola invisível.
		var animaçao_bola: AnimatedSprite2D = Bola_em_questao.get_node("Fireball")
		animaçao_bola.visible = false
		
		# Torna a própria bola invisível.
		Bola_em_questao.visible = false

# Função que obtém o valor atual de 'progress_ratio' da bola (posição no caminho).
func get_Bola(cu: PathFollow2D):
	var bola: float = cu.get("progress_ratio")
	return bola

# Função para desativar a rotação das bolas.
func desativar():
	# Define a variável 'girando' como falsa, desativando a rotação.
	girando = false
