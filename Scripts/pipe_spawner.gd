extends Node
class_name PipeSpawner

var pipe_pair_scene = preload("res://Scenes/pipe_pair.tscn")

@export var pipe_speed = -150
@onready var spawn_timer = $SpawnTimer

signal character_crashed
signal point_scored

func _ready():
	spawn_timer.timeout.connect(spawn_pipe)

func start_spawning_pipes():
	spawn_timer.start()
	
func spawn_pipe():
	var pipe = pipe_pair_scene.instantiate() as PipePair
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	var half_height = viewport_rect.size.y / 2
	pipe.position.x = viewport_rect.end.x
	pipe.position.y = randf_range(viewport_rect.size.y * -0.4 - half_height, viewport_rect.size.y * 0.1 - half_height)
	
	pipe.bird_entered.connect(on_character_entered)
	pipe.point_scored.connect(on_point_scored)
	pipe.set_speed(pipe_speed)

func on_character_entered():
	character_crashed.emit()
	stop()

func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is PipePair):
		(pipe as PipePair).speed = 0
	
func on_point_scored():
	point_scored.emit()
