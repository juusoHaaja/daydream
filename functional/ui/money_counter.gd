extends Control

var current_displayed: int = 0
var target_count: int = 0

# adjust these:
var min_speed: float = 100.0  # minimal increment per second for small differences
var factor: float = 5.0      # how strongly step size scales with difference

func _process(delta: float) -> void:
    if current_displayed != target_count:
        var diff = target_count - current_displayed
        # step grows with difference
        var step = max(min_speed, abs(diff) * factor) * delta
        step = ceil(step)
        # clamp so we don't overshoot
        if abs(diff) <= step:
            current_displayed = target_count
        else:
            current_displayed += step * sign(diff)

        $Label.text = "Funding: %d billion $" % current_displayed

func update_count(new_count: int) -> void:
    target_count = new_count
