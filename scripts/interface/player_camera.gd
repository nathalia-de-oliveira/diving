extends Camera2D

func _ready() -> void:
	
	#TODO: Quando muda pra uma fase que não tenha a camera tem um bug aqui
	if get_parent().get_parent().get_node("CameraLimit") != null:
	
		var camera_limit_tiles = get_parent().get_parent().get_node("CameraLimit")
	
		var map_limits = camera_limit_tiles.get_used_rect()
		
		self.limit_left = map_limits.position.x*16+16
		self.limit_right = map_limits.end.x*16-16
		self.limit_top = map_limits.position.y*16+16
		self.limit_bottom = map_limits.end.y*16-16
		
	else:
		self.limit_left = -100000000
		self.limit_right = 100000000
		self.limit_top = -100000000
		self.limit_bottom = 100000000 
