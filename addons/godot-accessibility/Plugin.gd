tool
extends EditorPlugin

var ScreenReader := preload("ScreenReader.gd")

func _enter_tree():
	add_autoload_singleton("TTS", "res://addons/godot-tts/TTS.gd")
	add_custom_type("ScreenReader", "Node", ScreenReader, null)


func _exit_tree():
	remove_custom_type("ScreenReader")
	remove_autoload_singleton("TTS")
