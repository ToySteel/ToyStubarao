extends Control

# Programação da missão atual no Canvas.
# Carrega o nó que contém o texto das missões assim que o nó é carregado.
@onready var missoes = $"container/Missoes/Texto Missoes"

# Função chamada a cada frame. 'delta' é o tempo decorrido desde o último frame.
func _process(delta):
	# Atualiza o texto do objeto 'missoes' com o conteúdo das missões atuais.
	# O texto é formatado usando a variável global 'Globals.Texto_missoes'.
	# 'str' converte o texto para string, se necessário.
	missoes.text = str("MISSOES:\n" + Globals.Texto_missoes)
