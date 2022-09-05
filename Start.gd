extends Control


onready var buttons = {
	"dk-dk": $LangOpts/DKDKBtn,
	"en-gb": $LangOpts/ENGBBtn,
	"fr-fr": $LangOpts/FRFRBtn,
	"de-de": $LangOpts/DEDEBtn,
	"ga-ie": $LangOpts/GAIEBtn,
	"nrf-je": $LangOpts/NRFJEBtn,
	"gv-im": $LangOpts/GVIMBtn,
	"no-no": $LangOpts/NONOBtn,
	"es-es": $LangOpts/ESESBtn,
	"sv-se": $LangOpts/SVSEBtn
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if buttons[PlayerVariables.get_language()]:
		buttons[PlayerVariables.get_language()].grab_focus()
	else:
		buttons["dk-dk"].grab_focus()
	for key in buttons:
		buttons[key].connect("pressed", self, "start_game", [key])

func start_game(key):
	PlayerVariables.set_language(key)
	get_tree().change_scene("res://Game.tscn")
