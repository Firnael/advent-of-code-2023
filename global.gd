extends Node2D

func _ready():
	print('Global script loaded')
	
func get_file_lines(path):
	var complete_path = "res://inputs/" + path
	var content: String
	if FileAccess.file_exists(complete_path):
		var file = FileAccess.open(complete_path, FileAccess.READ)
		content = file.get_as_text()
	else:
		content = "File does not exists : " + complete_path
	var lines = Array(content.split('\n')) # casting the PackedStringArray to normal array
	lines.pop_back()  # godot adds an empty last line, remove it
	return lines

func pretty_print_array(array):
	for x in array:
		print(x)
