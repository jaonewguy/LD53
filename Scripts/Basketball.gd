extends Sprite

onready var bball = self

func _ready() -> void:
    pass

func _physics_process(_delta: float) -> void:
    bball.global_position = get_global_mouse_position()
