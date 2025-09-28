extends Node2D
class_name Main

static var instance;

@onready var canvas = $RedCanvas
@onready var nuke_man = $Nukeman 
@onready var water_kill = $WaterKillTexture
@onready var plane_manager = $PlaneManager
@onready var killcount = $GUI/MarginContainer/VBoxContainer/KillCount
@onready var money_count = $GUI/MarginContainer/VBoxContainer/MoneyCounter

@onready var end_screen = $EndScreen

var kill_count = 0;
var population = 8240000000

var money = 0;

func _ready() -> void:
    instance = self
    canvas.main = self
    nuke_man.main = self
   #Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) # hide cursor

func update_kill_count():
    killcount.update_count(kill_count)

func update_money_count():
    money_count.update_count(money)

func set_end_screen():
    end_screen.visible = true
