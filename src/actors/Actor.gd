extends KinematicBody2D
class_name Actor

const FLOOR_UP := Vector2.UP

export var max_health: int
export var max_speed: float
export var jump_force: float
export var gravity := 2000.0

var health := max_health
var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	control()

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func control() -> void:
	pass
