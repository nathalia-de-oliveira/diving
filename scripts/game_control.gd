extends Control

@onready var level_control = $LevelControl

func _ready() -> void:
	level_control.current_level = 0
