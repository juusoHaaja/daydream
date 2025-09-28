extends MarginContainer

var price = 100
var one_off = false;
var avaliable = true;
@export var upgrade_index = 0;

@onready var button = $VBoxContainer/Button
@onready var label = $VBoxContainer/Label

func _ready() -> void:
    button.pressed.connect(Callable(self, "on_button_pressed"))
    match upgrade_index:
        0:
            price = 25000000000
        1:
            price = 34500000000
        2:
            price = 68100000000
        3:
            price = 829500000000
            one_off = true
    
    label.text =  "$" + format_with_commas(price)

func on_button_pressed() -> void:
    if avaliable:
        var main = Main.instance
        if main.money >= price:
            main.money -= price
            main.update_money_count()
            match upgrade_index:
                0: # Bomb Radius
                    Main.instance.nuke_man.nuke_radius += 5.0
                1: # Firing Speed
                    Main.instance.nuke_man.nuke_cooldown *= 0.9
                2: # Rocket Velocity
                    Main.instance.nuke_man.speed_mul += 0.25
                3: # Radiation
                    Main.instance.nuke_man.nuke_radiation = true
            increase_price()

func increase_price() -> void:
    price = int(price * 2)
    label.text =  "$" + format_with_commas(price)
    if one_off:
        avaliable = false
        button.disabled = true
        label.text = "SOLD OUT"


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
