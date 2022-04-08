extends Control

export (String, FILE) var next_scene_path

onready var time_value := $MarginContainer/VBoxContainer/VBoxContainer/TimeContainer/TimeValue
onready var score_value := $MarginContainer/VBoxContainer/VBoxContainer/ScoreContainer/ScoreValue

func _ready() -> void:
	time_value.text = format_time()
	time_value.show()
	
	score_value.text = "%06d" % [GameData.total_score]
	score_value.show()
	
	$MarginContainer/VBoxContainer/RestartButton.grab_focus()
	
	$ResultSFX.play()

func format_time() -> String:
	var minutes := GameData.total_time / 60
	var seconds := fmod(GameData.total_time, 60)
	var milliseconds := fmod(GameData.total_time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func _on_RestartButton_pressed() -> void:
	GameData.reset()
	$RestartSFX.play()
	yield($RestartSFX,"finished")
	get_tree().change_scene(next_scene_path)
