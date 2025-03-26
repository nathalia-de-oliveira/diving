extends Control

@onready var health_bar = $MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/HealthBar
@onready var gas_bar = $MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer/GasBar
@onready var clock_number = $MarginContainer/HBoxContainer3/ClockTextureRect/ClockNumber

var margin_size = 14 #margin + texture

func _ready():
	update_gas_bar()
	set_gas()
	update_health_bar()
	set_health()
	
func update_gas_bar():
	gas_bar.custom_minimum_size.x = PLAYERSTATS.max_gas
	gas_bar.max_value = PLAYERSTATS.max_gas + margin_size
	
func set_gas():
	gas_bar.value = PLAYERSTATS.player_gas
	
func update_health_bar():
	health_bar.custom_minimum_size.x = PLAYERSTATS.max_health
	health_bar.max_value = PLAYERSTATS.max_health + margin_size
	
func set_health():
	health_bar.value = PLAYERSTATS.player_health
	
func _on_breathing_timeout() -> void:
	PLAYERSTATS.player_gas -= 1
	set_gas()
	
func _on_level_control_level_changed(level):
	$MarginContainer/HBoxContainer3/ClockTextureRect/ClockNumber.text = str(level)
