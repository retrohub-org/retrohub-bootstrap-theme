extends Node

# _ready function, called everytime the theme is loaded, and only once
func _ready():
	# App related signals
	RetroHub.connect("app_initializing", self, "_on_app_initializing")
	RetroHub.connect("app_closing", self, "_on_app_closing")
	RetroHub.connect("app_received_focus", self, "_on_app_received_focus")
	RetroHub.connect("app_lost_focus", self, "_on_app_lost_focus")
	RetroHub.connect("app_returning", self, "_on_app_returning")

	# Content related signals
	RetroHub.connect("system_receive_start", self, "_on_system_receive_start")
	RetroHub.connect("system_received", self, "_on_system_received")
	RetroHub.connect("system_receive_end", self, "_on_system_receive_end")
	RetroHub.connect("game_receive_start", self, "_on_game_receive_start")
	RetroHub.connect("game_received", self, "_on_game_received")
	RetroHub.connect("game_receive_end", self, "_on_game_receive_end")
	
	# Config related signals
	RetroHubConfig.connect("config_ready", self, "_on_config_ready")
	RetroHubConfig.connect("config_updated", self, "_on_config_updated")
	RetroHubConfig.connect("theme_config_ready", self, "_on_theme_config_ready")
	RetroHubConfig.connect("theme_config_updated", self, "_on_theme_config_updated")
	RetroHubConfig.connect("system_data_updated", self, "_on_system_data_updated")
	RetroHubConfig.connect("game_data_updated", self, "_on_game_data_updated")
	RetroHubConfig.connect("game_media_data_updated", self, "_on_game_media_data_updated")

#_unhandled_input, called at every input event
# use this function for input (not _input/_process) for
# proper behavior with RetroHub
func _unhandled_input(event):
	pass

## Called when RetroHub is initializing your theme.
## This can either happen when RetroHub is launching, or
## the theme was changed to this one.
func _on_app_initializing():
	pass

## Called when RetroHub is unitializing your theme.
## This can either happen when RetroHub is closing, or
## the theme was changed to another one.
##
## While this function can block for the duration needed
## (if, for example, you want to do a custom "exiting" animation),
## do not do anything that takes too long.
func _on_app_closing():
	pass

## Called when RetroHub window receives focus without any current game launched.
## Use this for any behavior desired (for example, re-enabling audio streams)
func _on_app_received_focus():
	pass

## Called when RetroHub window loses focus without any current game launched.
## Use this for any behavior desired (for example, muting audio streams)
func _on_app_lost_focus():
	pass

## Called when RetroHub is returning from a launched game back into focus.
## The way RetroHub works, signals "app_initialized", and all "system_received"
## and "game_received" signals are sent before this signal is fired, as themes
## are unloaded during games to reduce memory footprint.
## Use this signal to recreate the UI state as it was before launching the game.
func _on_app_returning(system_data: RetroHubSystemData, game_data: RetroHubGameData):
	pass

## Called when RetroHub is about to send all system data.
func _on_system_receive_start():
	pass

## Called when RetroHub has information of a game system available.
## It's entirely up to you how to display that system information.
## RetroHub only sends information from systems with detected games.
##
## System information always arrives before game information.
func _on_system_received(data: RetroHubSystemData):
	print("System received: %s [%s]" % [data.fullname, data.name])

## Called when RetroHub has finished sending all system data.
## Game data will follow immediately after this.
func _on_system_receive_end():
	pass

## Called when RetroHub is about to send all game data.
## At this point, all system data has been sent to the theme.
func _on_game_receive_start():
	pass

## Called when RetroHub has information of a game available.
## It's entirely up to you how to display that game information.
##
## Game information always arrives after system information.
func _on_game_received(data: RetroHubGameData):
	print("Game received: %s [%s]" % [data.name, data.system_name])

## Called when RetroHub has finished sending all game data.
func _on_game_receive_end():
	pass

## Called when RetroHub's configuarion has finished loading.
## Use this to customize your theme appearance according to
## user configuration
func _on_config_ready(config_data: ConfigData):
	pass

## Called when some RetroHub config has been changed by the user.
## Check which key is from ConfigData.KEY_(...).
func _on_config_updated(key, old_value, new_value):
	pass

## Called when the theme's configuarion has finished loading.
## Use this to customize your theme appearance according to
## your own custom configuration.
## 
## Always use RetroHubConfig.get_theme_config() / RetroHubConfig.set_theme_config()
## to access your theme configurations. This ensures proper
## behavior when reading/saving
## settings
func _on_theme_config_ready():
	pass

## Called when some theme config has been changed by the user.
func _on_theme_config_updated(key, old_value, new_value):
	pass

## Called when any system information has been changed by the user.
## The given reference is identical to one passed earlier from the
## "system_received" signal, so you can use this to detect which
## system changed and only updated that data.
func _on_system_data_updated(data: RetroHubSystemData):
	pass

## Called when any game information has been changed by the user.
## This can happen via automatic scraping or manual edits. The
## given reference is identical to one passed earlier from the
## "game_received" signal, so you can use this to detect which
## game changed and only updated that data.
func _on_game_data_updated(data: RetroHubGameData):
	pass

## Called when any game media information has been changed by the user.
## This can happen via automatic scraping or manual edits. The given
## reference is identical to one requested earlier from
## "RetroHubMedia.retrieve_media_data()", so you can use this to detect
## which game media changed and only updated that data.
func _on_game_media_data_updated(data: RetroHubGameMediaData):
	pass
