extends Node

@onready var SFX : AudioStreamPlayer = $SFX
@onready var musicPlayer : AudioStreamPlayer = $musicPlayer
var musicNum : int = 1 ## Índice referente a cada musica da playlist

## Banco de dados das musicas(Playlist)
var musicDatabase : Dictionary = {
	1: preload("res://Assets/City Rush1.mp3"),
	2: preload("res://Assets/City Rush2.mp3")
}

## Inicia a musica de fundo com o indice inicial
func _ready() -> void:
	playMusic(musicNum)
	print(musicPlayer.stream)

## Função de controle e legibilidade para o play da musica atual
func playMusic(index) -> void:
	musicPlayer.stream = musicDatabase.get(index) # Seleciona a musica da playlist com base no índice
	musicPlayer.play()
	
func playSFX(song) -> void:
	SFX.stream = song
	SFX.play()

func backMusicFinished():
	print("musica acabou")
	## Verifica se há proxima musica e itera o índice, caso não volta ao indice inicial
	if musicNum >= musicDatabase.size():
		musicNum = 1
	else:
		musicNum += 1
	
	## Atribuição do indice atual e inicio da musica selecionada
	playMusic(musicNum)
	print(musicNum >= musicDatabase.size())
