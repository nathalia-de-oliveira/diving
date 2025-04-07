extends Camera2D

func _ready() -> void:
	
	var camera_limit_tiles = get_parent().get_parent().get_node("CameraLimit")
	
	if camera_limit_tiles != null:
		var map_limits = camera_limit_tiles.get_used_rect()
		
		self.limit_left = map_limits.position.x*16+16
		self.limit_right = map_limits.end.x*16-16
		self.limit_top = map_limits.position.y*16+16
		self.limit_bottom = map_limits.end.y*16-16
