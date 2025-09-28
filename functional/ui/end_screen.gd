extends CanvasLayer

@onready var play_button = $Panel/MarginContainer/VBoxContainer/Button
@onready var stat_slabel = $Panel/MarginContainer/VBoxContainer/StatsLabel

func _ready() -> void:
    play_button.pressed.connect(Callable(self, "on_play_button_pressed"))

func on_play_button_pressed() -> void:
    get_tree().change_scene_to_file("res://functional/world/main.tscn")

func display_stats():
    var main = Main.instance
    stat_slabel.text = "Casualities: " + format_with_commas(main.kill_count) + "\n" + "Outbreaks neutralized: " + format_with_commas(main.canvas.infected_kills) + "\n" + "Population: " + format_with_commas(main.population)

func format_with_commas(n: int) -> String:
    var s = str(abs(n))
    var result = ""
    while s.length() > 3:
        result = "," + s.substr(s.length() - 3, 3) + result
        s = s.substr(0, s.length() - 3)
    result = s + result
    if n < 0:
        result = "-" + result
    return result
