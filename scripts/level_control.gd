extends Control

var level_path = "res://scenes/level/"

signal level_changed(level)

var current_level

func _ready() -> void:
	var start_level = 0
	change_level(start_level)
	
func change_level(new_level):
	current_level = new_level
	PLAYERSTATS.level = current_level
	load_level(current_level)
	level_changed.emit(current_level)
	
func load_level(level_number):
	var old_level = level_number - 1
	
	var level_scene = load(level_path+str(level_number)+".tscn")
	var level_instance = level_scene.instantiate()
	add_child(level_instance)
	
	if old_level != -1:
		var old_level_scene = get_node("./" + str(old_level))
		old_level_scene.queue_free()
