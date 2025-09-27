extends Node2D
class_name Main

static var instance;

@onready var canvas = $RedCanvas
@onready var nuke_man = $Nukeman 
@onready var water_kill = $WaterKillTexture
@onready var killcount = $GUI/MarginContainer/KillCount

var kill_count = 0;
var population = 8240000000

func _ready() -> void:
    instance = self
    canvas.main = self
    nuke_man.main = self

func update_kill_count():
    killcount.update_count(kill_count)
