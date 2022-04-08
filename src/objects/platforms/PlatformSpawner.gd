extends Node2D

export var platform: PackedScene
export var platform_speed: float

func _on_Timer_timeout() -> void:
	var pl := platform.instance()
	add_child(pl)
	pl.mode = pl.MODES.VERTICAL
	pl.speed = platform_speed
