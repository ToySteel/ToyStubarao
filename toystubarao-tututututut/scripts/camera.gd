extends Camera2D

# Referência para o temporizador que controla o tempo de duração do efeito de tremer a câmera.
@onready var timer: Timer = $Timer

# Cria um Tween para animações suaves de propriedades.
@onready var tween: Tween = get_tree().create_tween()

# Intensidade do efeito de tremer a câmera.
var shake_amount = 0

# Deslocamento inicial da câmera.
var initial_offset = 0

# Deslocamento padrão da câmera.
var default_offset = 5

# Função chamada quando o nó entra na árvore da cena pela primeira vez.
func _ready() -> void:
	# Desativa o processamento contínuo inicialmente.
	set_process(false)
	
	# Atribui a câmera atual ao objeto global 'Globals.camera'.
	Globals.camera = self

# Função chamada a cada frame. Responsável por aplicar o efeito de tremer na câmera.
func _process(delta: float) -> void:
	# Define um deslocamento aleatório para a câmera com base no 'shake_amount'.
	offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(shake_amount, -shake_amount))

# Função para iniciar o efeito de tremer a câmera.
# new_shake: intensidade do tremor.
# shake_time: duração do tremor.
# shake_limit: limite máximo para a intensidade do tremor.
func Shake_camera(new_shake, shake_time = 0.4, shake_limit = 20):
	# Ativa o processamento contínuo para aplicar o tremor da câmera.
	set_process(true)
	
	# Aumenta a intensidade do tremor de acordo com o valor passado em 'new_shake'.
	shake_amount += new_shake
	
	# Limita a intensidade do tremor ao valor máximo definido por 'shake_limit'.
	if shake_amount > shake_limit:
		shake_amount = shake_limit
	
	# Configura o tempo de espera do temporizador para a duração do tremor.
	timer.wait_time = shake_time
	# Inicia o temporizador para contar o tempo do efeito de tremor.
	timer.start()

# Função que é chamada quando o temporizador termina (tempo de tremor acaba).
func _on_timer_timeout() -> void:
	# Desativa o processamento contínuo, encerrando o tremor da câmera.
	set_process(false)
	
	# Reseta a intensidade do tremor para 0.
	shake_amount = 0.0
	
	# Reseta o deslocamento da câmera para a posição padrão.
	offset.x = 0
	offset.y = 0
	
	# Usa o Tween para suavizar a transição do deslocamento da câmera para o offset inicial.
	tween.tween_property(self, "offset", initial_offset, default_offset)
	
	# Espera o término da animação Tween antes de continuar.
	await tween.finished
