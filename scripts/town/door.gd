extends Area2D

@export var target_scene_path: String = ""
@export var target_spawn_point_name : String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var root : Node2D = get_tree().current_scene
		if root.has_method("load_level"):
			root.call_deferred("load_level", target_scene_path, target_spawn_point_name)
