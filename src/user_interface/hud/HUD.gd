extends MarginContainer

onready var time_value := $HBC/TimeScoreContainer/TimeContainer/TimeValue
onready var score_value := $HBC/TimeScoreContainer/ScoreContainer/ScoreValue

func show_hud():
	visible = true

func hide_hud():
	visible = false

func set_time_value():
	time_value.text = format_time()
	time_value.show()

func set_score_value():
	score_value.text = "%06d" % [GameData.score]
	score_value.show()

func format_time() -> String:
	var minutes := GameData.time / 60
	var seconds := fmod(GameData.time, 60)
	var milliseconds := fmod(GameData.time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
