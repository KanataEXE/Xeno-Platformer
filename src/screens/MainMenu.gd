extends Control

onready var parallax_layer := $ParallaxBackground/ParallaxLayer

export (String, FILE) var next_scene_path

var background_speed := -200

func _ready() -> void:
	$MarginContainer/VB/VB/StartGame.grab_focus()
	$MainTheme.play()

func _process(delta: float) -> void:
	parallax_layer.motion_offset.x += background_speed * delta

func new_game() -> void:
	$StartSFX.play()
	$FadeTransition.start()
	yield($FadeTransition/Tween, "tween_all_completed")
	get_tree().change_scene(next_scene_path)
