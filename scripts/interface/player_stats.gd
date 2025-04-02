extends Control

@onready var health_bar = $MarginContainer/HBoxContainer/VBoxContainer/HealthBar
@onready var stamina_bar = $MarginContainer/HBoxContainer/VBoxContainer/StaminaBar
@onready var clock_number = $MarginContainer/HBoxContainer/ClockTextureRect/ClockNumber

func _ready():
	update_health_bar()
	set_health()
	
	update_stamina()
	set_stamina()
	
func update_health_bar():
	health_bar.custom_minimum_size.x = PLAYERSTATS.max_health
	health_bar.max_value = PLAYERSTATS.max_health + 9
	
func set_health():
	health_bar.value = PLAYERSTATS.player_health

func set_stamina():
	stamina_bar.value = PLAYERSTATS.player_stamina

func update_stamina():
	stamina_bar.custom_minimum_size.x = PLAYERSTATS.max_stamina
	stamina_bar.max_value = PLAYERSTATS.max_stamina + 9
	
	
func _on_level_control_level_changed(level):
	$MarginContainer/HBoxContainer/ClockTextureRect/ClockNumber.text = str(level)
