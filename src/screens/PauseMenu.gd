extends ColorRect

onready var scene_tree: SceneTree = get_tree()
onready var pause_sfx := $PauseSFX
onready var unpause_sfx := $UnpauseSFX

var paused: bool = false setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not self.paused
		if paused:
			pause_sfx.play()
		else:
			unpause_sfx.play()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	visible = value
