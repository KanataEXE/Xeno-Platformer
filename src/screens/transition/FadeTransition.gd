extends CanvasLayer

onready var tween := $Tween

func start():
	tween.interpolate_property($ColorRect, "modulate", Color.transparent, Color.white, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
