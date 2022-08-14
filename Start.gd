extends Control

onready var pickLanguageSelect = $PickLanguage
onready var startBtn = $StartBtn

# Called when the node enters the scene tree for the first time.
func _ready():
	pickLanguageSelect.add_item("Spanish")
	pickLanguageSelect.select(0)
	startBtn.disabled = false
	pickLanguageSelect.set_item_metadata(0, "es-es")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartBtn_pressed():
	if pickLanguageSelect.is_anything_selected():
		var selected = pickLanguageSelect.get_selected_items()
		PlayerVariables.language = pickLanguageSelect.get_item_metadata(selected[0])
		get_tree().change_scene("res://Main.tscn")


func _on_PickLanguage_item_selected(index):
	startBtn.disabled = false
