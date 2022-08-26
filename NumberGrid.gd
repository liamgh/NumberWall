extends VBoxContainer

onready var optBtns = [
	$Row1/Option1,
	$Row1/Option2, 
	$Row1/Option3,  
	$Row1/Option4,  
	$Row1/Option5,  
	$Row2/Option6,  
	$Row2/Option7,  
	$Row2/Option8,  
	$Row2/Option9,  
	$Row2/Option10]
	
const rightStyle : Resource = preload("res://correct.tres")
const wrongStyle : Resource = preload("res://wrong.tres")
const focusStyle : Resource = preload("res://focus.tres")
var correctAnswerBtn : int = -1
var kbNavEnabled : bool = false

# Try to detect moving from mouse/touch to keyboard/gamepad mode and vice versa
func _input(event):			
	if (event is InputEventKey or event is InputEventJoypadMotion or event is InputEventJoypadButton) and !kbNavEnabled:
		kbNavEnabled = true;
		optBtns[0].grab_focus()
		reset_grid_styles()
				
	if (event is InputEventScreenTouch or event is InputEventMouseMotion)  and kbNavEnabled:
		kbNavEnabled = false
		reset_grid_styles()

func change_all_styles(buttonNo, style):
	optBtns[buttonNo].set("custom_styles/normal", style)
	optBtns[buttonNo].set("custom_styles/hover", style)
	optBtns[buttonNo].set("custom_styles/focus", style)
	optBtns[buttonNo].set("custom_styles/selected", style)

func disable_all_but(buttonNo):
	for i in range(0, len(optBtns)):
		if i != buttonNo:
			optBtns[i].disabled = true
			
func _on_Game_correct_answer(buttonNo):
	change_all_styles(buttonNo, rightStyle)
	disable_all_but(buttonNo)

func _on_Game_wrong_answer(buttonNo):
	change_all_styles(buttonNo, wrongStyle)

func _on_Game_new_question(correctAnswerBtn, answers):
	self.correctAnswerBtn = correctAnswerBtn
	for i in range(0, len(answers)):
		optBtns[i].text = str(answers[i])  
	reset_grid_styles()	

func reset_grid_styles():
	print_debug("Reseting style")
	for i in range(0, len(optBtns)):
		optBtns[i].set("custom_styles/normal", StyleBoxEmpty)
		optBtns[i].set("custom_styles/hover", StyleBoxEmpty)	     
		optBtns[i].disabled = false
		if (kbNavEnabled):
			optBtns[i].set("custom_styles/focus", focusStyle)			
		else:
			optBtns[i].set("custom_styles/focus", StyleBoxEmpty)

func _on_Game_hide_options(howMany):
	var numHidden = 0
	while numHidden != howMany:
		var i = randi() % len(optBtns)-1
		if i != correctAnswerBtn and !optBtns[i].disabled:
			numHidden = numHidden + 1
			optBtns[i].text = ""
			optBtns[i].disabled = true


func _on_Game_reset_grid():
	reset_grid_styles()
