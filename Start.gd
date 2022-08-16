extends Control

onready var pickLanguageSelect = $PickLanguage
onready var startBtn = $StartBtn

# Called when the node enters the scene tree for the first time.
func _ready():
	addLanguageToMenu("es-es", "Spanish")
	addLanguageToMenu("dk-dk", "Danish")
	addLanguageToMenu("en-gb", "English")
	addLanguageToMenu("sv-se", "Swedish")
	pickLanguageSelect.select(0)
	startBtn.disabled = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func addLanguageToMenu(code, name):
	var i = pickLanguageSelect.get_item_count()
	pickLanguageSelect.add_item(name)
	pickLanguageSelect.set_item_metadata(i, code)


func _on_StartBtn_pressed():
	if pickLanguageSelect.is_anything_selected():
		var selected = pickLanguageSelect.get_selected_items()
		PlayerVariables.language = pickLanguageSelect.get_item_metadata(selected[0])
		get_tree().change_scene("res://Main.tscn")


func _on_PickLanguage_item_selected(index):
	startBtn.disabled = false
