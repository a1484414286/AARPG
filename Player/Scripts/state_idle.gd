class_name State_Idle extends State
@onready var walk: State_Walk = $"../Walk"

# What happens when the player enters this State?
func Enter() -> void:
	player.updateAnimation("idle")
	pass

# What happens when the player exists this State?
func Exit() -> void:
	pass

# What happens during the _process update in this State?
func Process(_delta: float)-> State:
	if player.updateDirection():
		return walk
	player.velocity = Vector2.ZERO
	return null;

# What happens during the _physics_process update in this State?
func Physics(_delta : float) -> State:
	return null;
	
func HandleInput(_event : InputEvent) -> State:
	return null
