extends Control

func update_count(new_count: int) -> void:
    $Label.text = "Casualities: %d" % new_count
