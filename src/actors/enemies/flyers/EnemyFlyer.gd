extends "res://src/actors/Actor.gd"
class_name EnemyFlyer

export var score: int

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -max_speed

func control() -> void:
	velocity.x *= -1 if is_on_wall() else 1
	$Sprite.flip_h = true if velocity.x > 0 else false
	velocity.y = move_and_slide(velocity, FLOOR_UP).y

func hit() -> void:
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	$HitArea/CollisionShape2D.set_deferred("disabled", true)
	if $AnimationPlayer.has_animation("die"):
		$AnimationPlayer.play("die")
	$HitSFX.play()
	yield($HitSFX,"finished")
	GameData.score += score
	queue_free()

func _on_HitArea_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		if body.has_method("hit"):
			body.hit()
