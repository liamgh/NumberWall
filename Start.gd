extends Control


@onready var buttons = {
	"dk-dk": $LangOpts/DKDKBtn,
	"en-gb": $LangOpts/ENGBBtn,
	"fr-fr": $LangOpts/FRFRBtn,
	"de-de": $LangOpts/DEDEBtn,
	"ga-ie": $LangOpts/GAIEBtn,
	"nrf-je": $LangOpts/NRFJEBtn,
	"gv-im": $LangOpts/GVIMBtn,
	"no-no": $LangOpts/NONOBtn,
	"es-es": $LangOpts/ESESBtn,
	"sv-se": $LangOpts/SVSEBtn,
	"cy-cy": $LangOpts/CYCYBtn
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Android":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if buttons[PlayerVariables.get_language()]:
		buttons[PlayerVariables.get_language()].grab_focus()
	else:
		buttons["dk-dk"].grab_focus()
	for key in buttons:
		buttons[key].connect("pressed", Callable(self, "start_game").bind(key))

func start_game(key):
	print_debug(key)
	PlayerVariables.set_language(key)
	get_tree().change_scene_to_file("res://Game.tscn")
