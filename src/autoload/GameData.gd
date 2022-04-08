extends Node

signal score_updated
signal time_updated

var score: int = 0 setget set_score
var time: float = 0 setget set_time
var total_score: int
var total_time: float

func reset() -> void:
	self.total_score = 0
	self.total_time = 0
	self.score = 0
	self.time = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func set_time(value: float) -> void:
	time = value
	emit_signal("time_updated")
