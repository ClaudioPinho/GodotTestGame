extends Node2D

export(NodePath) var interactable_tilemap_node_path

onready var interactable_tilemap = get_node(interactable_tilemap_node_path)
#
#func get_curr_interactable_tile():
#
