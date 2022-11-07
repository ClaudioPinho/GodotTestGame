extends Camera2D

export(NodePath) var follow_node
onready var player_node_ref = get_node(follow_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_node_ref != null:
		position = player_node_ref.position
