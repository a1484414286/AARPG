class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle: State_Idle = $"../Idle"

# What happens when the player enters this State?
func Enter() -> void:
	player.updateAnimation("walk")
	pass

# What happens when the player exists this State?
func Exit() -> void:
	pass

# What happens during the _process update in this State?
func Process(_delta: float)-> State:
	#only suppose to return other types of State
	if player.current_direction == Vector2.ZERO:
		return idle
	#since this will always trigger because of player's _process
	#it will always do changeState, but it will be blocked because
	#new_state == current_state, so it's not too useful to return walk here
	player.velocity = player.current_direction * move_speed
	if player.updateDirection():
		Enter();
	return null;

# What happens during the _physics_process update in this State?
func Physics(_delta : float) -> State:
	return null;
	
func HandleInput(_event : InputEvent) -> State:
	return null
