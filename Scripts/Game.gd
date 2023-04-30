extends Node2D

onready var hoop = $Hoop

# Screen points
var point1 = Vector2(0,0)
var point2 = Vector2(0,0)

# Define basic variables and settings
var time = 0
var timeDirection = 1
var moveDuration = 2

func _ready() -> void:
    var screenSize = get_viewport().get_visible_rect().size
    point1 = Vector2(screenSize.x * 0.1, screenSize.y * 0.6)
    point2 = Vector2(screenSize.x - (screenSize.x * 0.1), screenSize.y * 0.6)

func _process(delta):

    # Flip the direction of how time gets added
    # This ensures it moves back to its initial position
    if (time > moveDuration or time < 0):
        timeDirection *= -1

    # delta is how long it takes to complete a frame.
    time += delta * timeDirection
    var t = time / moveDuration

    hoop.position = lerp(point1,point2, t)
