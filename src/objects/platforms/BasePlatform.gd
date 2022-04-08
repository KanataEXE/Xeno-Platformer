extends KinematicBody2D

enum MODES {VERTICAL, HORIZONTAL}

export var speed: float

var direction: Vector2
var mode: int

func _ready() -> void:
	match mode:
		MODES.VERTICAL:
			direction = Vector2.DOWN
		MODES.HORIZONTAL:
			direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	if mode == MODES.VERTICAL:
		if global_position.y > 1216 or global_position.y < 0:
			queue_free()
