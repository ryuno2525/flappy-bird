extends Node
class_name GameManager

@onready var character = $"../Character" as Character
@onready var ground = $"../Ground" as Ground
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var ui = $"../UI" as UI

var points = 0

func _ready():
	character.game_started.connect(on_game_started)
	ground.character_crashed.connect(end_game)
	pipe_spawner.character_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)
	
func on_game_started():
	pipe_spawner.start_spawning_pipes()

func end_game():
	ground.stop()
	character.stop()
	pipe_spawner.stop()
	ui.on_gameover()

func on_point_scored():
	points += 1
	ui.update_points(points)
