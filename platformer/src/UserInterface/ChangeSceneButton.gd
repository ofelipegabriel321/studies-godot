tool
extends Button

#   (String, FILE) significa que será uma String e que aponta para um caminho
# de arquivo
export(String, FILE) var next_scene_path: = ""

func _on_button_up() -> void:
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""
