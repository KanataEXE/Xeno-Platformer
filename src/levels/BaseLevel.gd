extends Node2D

onready var scene_tree = get_tree()
onready var hud := $InterfaceLayer/HUD
onready var pause_menu := $InterfaceLayer/PauseMenu
onready var fade_transition := $FadeTransition
onready var level_music := $LevelMusic

export (String, FILE) var next_scene_path

func _ready() -> void:
	set_process(true)
	hud.show()
	hud.set_score_value()
	GameData.connect("score_updated", hud, "set_score_value")
	GameData.connect("time_updated", hud, "set_time_value")
	level_music.play()

func _process(delta: float) -> void:
	GameData.time += delta

func change_scene() -> void:
	set_process(false)
	hud.hide()
	level_music.stop()
#	scene_tree.paused = true
	
	GameData.total_score += GameData.score
	GameData.total_time += GameData.time
	GameData.score = 0
	GameData.time = 0
	
	fade_transition.start()
	yield(fade_transition.get_node("Tween"), "tween_all_completed")
#	scene_tree.paused = false
	get_tree().change_scene(next_scene_path)
