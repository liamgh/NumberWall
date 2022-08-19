# Variables shared between scenes
# Also provides access to player settings
# See https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html

extends Node

export var file_name = "user://settings.tres"
export var score = 0
var savedSettings : SavedSettings

func _init():
	# Load up the saved settings if they exist
	if ResourceLoader.exists(file_name):
		savedSettings = ResourceLoader.load(file_name)
	else:
		savedSettings = SavedSettings.new()

func get_language():
	return savedSettings.language
	
# Set the language for this game
func set_language(language):
	savedSettings.language = language
	if ! language in savedSettings.high_scores:
		print_debug("Creating score entry")
		savedSettings.high_scores[savedSettings.language] = 0
	save()
	

func save():
	var result = ResourceSaver.save(file_name, savedSettings)
	assert(result == OK)


# Sets saved high score to this high score
func get_high_score():
	return savedSettings.high_scores[savedSettings.language]
	
# Sets saved high score to this high score
func set_high_score():
	savedSettings.high_scores[savedSettings.language] = score

func is_high_score():
	return savedSettings.high_scores[savedSettings.language] < score
