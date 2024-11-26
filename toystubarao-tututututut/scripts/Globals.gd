extends Node2D

# Variáveis de inicialização
func _ready() -> void:
	# Criação de um array e adição de um elemento
	var array = [1, 2, 3]
	array += [4]  # Adiciona o valor 4 ao array
	print(array)  # Exibe o conteúdo do array no console

# Variáveis do jogo
var from_world  # Provavelmente utilizada para armazenar o mundo ou estado atual.
var Missoes = 0  # Controla a missão atual.
var Texto_missoes  # Texto que descreve o objetivo atual da missão.
var transmissor = "false"  # Indica o estado de um transmissor.
var chave_hollow_path = false  # Indica se a chave do Hollow_path foi encontrada.
var Game_point = "Start"  # Define o ponto inicial do jogo.
var camera = null  # A câmera, possivelmente para movimentação ou controle.
var Gelo = false  # Talvez um estado relacionado ao gelo no jogo.
var Checkpoints: String = "0"  # A rastreabilidade dos checkpoints do jogo.

# Função chamada a cada frame. 'delta' é o tempo decorrido desde o último frame.
func _process(delta):
	if Missoes == 0:
		Texto_missoes ="Fale Com a mulher holograma"
	if Missoes == 1:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna
		"
	if Missoes == 2:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes
		"
	if Missoes == 3:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Proucure o mergulhador
		"
	if Missoes == 4:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Proucure o mergulhador[ERRO]
		Ehh... Esta trancado, e nao sei onde esta a chave
		Mas aquele mato um pouco atraz estava muito suspeito
		"
	if Missoes == 5:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Entre na caverna e proucure uma chave para abrir a porta
		"
	if Missoes == 6:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Entre na caverna e proucure uma chave para abrir a porta[OK]
		Proucure o mergulhador
		"
	if Missoes == 7:
		Texto_missoes = "Va ate Magma Throth"

	# Verifica se o jogador pressionou a tecla para finalizar a missão.
	if Input.is_action_just_pressed("ui_end"):
		from_world = "Hollow_path"  # Define o próximo mundo ou área.
		Game_point = "Hollow_Path_Pos"  # Atualiza o ponto de jogo.
