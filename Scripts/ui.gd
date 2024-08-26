extends CanvasLayer
class_name UI

@onready var points_label = $"Points Label"
@onready var game_over_box = $"MarginContaine/Game Over Box"


func _on_ready():
	points_label.text = "0 point"

func on_gameover():
	game_over_box.visible = true

func update_points(points):
	var string_points = str(points)
	points_label.text = string_points + " points"

func _on_button_pressed():
	get_tree().reload_current_scene()
