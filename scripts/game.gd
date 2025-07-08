extends Node2D

const INITIAL_SCENE_PATH : String = "res://scenes/town/Town1.tscn"

@onready var level_root: Node2D = $LevelRoot
@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	load_level(INITIAL_SCENE_PATH)
	
func load_level(scene_path: String, spawn_point_name : String = "PlayerSpawnPoint") -> void:
	for child in level_root.get_children():
		child.queue_free()
	
	var packed_scene : Resource = load(scene_path)
	var new_level : Node2D = packed_scene.instantiate()
	
	level_root.add_child(new_level)
	
	var spawn_point : Node2D = find_node_recursive(new_level, spawn_point_name)
	if spawn_point:
		player.global_position = spawn_point.global_position
	else:
		push_warning("Spawn point not found : %s" % spawn_point_name)
		
func find_node_recursive(root: Node, node_name: String) -> Node:
	if root.name == node_name:
		return root
	for child in root.get_children():
		var found : Node = find_node_recursive(child, node_name)
		if found != null:
			return found
	return null
