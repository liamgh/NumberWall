extends Control

onready var pickLanguageSelect = $PickLanguage
onready var startBtn = $StartBtn

# Called when the node enters the scene tree for the first time.
func _ready():
	addLanguageToMenu("es-es", "Spanish")
	addLanguageToMenu("dk-dk", "Danish")
	addLanguageToMenu("en-gb", "English")
	addLanguageToMenu("sv-se", "Swedish")
	addLanguageToMenu("fr-fr", "French")
	addLanguageToMenu("gv-im", "Manx")
	addLanguageToMenu("no-no", "Norweigian")
	addLanguageToMenu("de-de", "German")
	addLanguageToMenu("ga-ie", "Irish")
	addLanguageToMenu("nrf-je", "Jèrriais")	
	startBtn.disabled = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func addLanguageToMenu(language, name):
	var i = pickLanguageSelect.get_item_count()
	pickLanguageSelect.add_item(name)
	pickLanguageSelect.set_item_metadata(i, language)
	# Select this if it was selected last time
	if language == PlayerVariables.get_language():
		pickLanguageSelect.select(i)


func _on_StartBtn_pressed():
	if pickLanguageSelect.is_anything_selected():
		var selected = pickLanguageSelect.get_selected_items()
		PlayerVariables.set_language(pickLanguageSelect.get_item_metadata(selected[0]))
		get_tree().change_scene("res://Main.tscn")

func _on_PickLanguage_item_selected(index):
	startBtn.disabled = false
