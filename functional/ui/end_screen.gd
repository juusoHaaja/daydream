extends CanvasLayer

@onready var play_button = $Panel/MarginContainer/VBoxContainer/Button

func _ready() -> void:
    play_button.pressed.connect(Callable(self, "on_play_button_pressed"))

func on_play_button_pressed() -> void:
    get_tree().change_scene_to_file("res://functional/world/main.tscn")
