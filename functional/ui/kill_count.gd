extends Control

var current_displayed: float = 0.0
var target_count: int = 0

@export var lerp_speed: float = 20.0	# how fast it catches up
@export var snap_threshold: float = 1.0 # snap to target when very close

func _process(delta: float) -> void:
    if current_displayed != float(target_count):
        # smooth interpolation
        current_displayed = lerp(current_displayed, float(target_count), lerp_speed * delta)

        # snap when very close
        if abs(current_displayed - target_count) < snap_threshold:
            current_displayed = float(target_count)

        $Label.text = "%s deaths" % format_with_commas(int(current_displayed))

func update_count(new_count: int) -> void:
    target_count = new_count

# Helper function to format number with commas every 3 digits
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
