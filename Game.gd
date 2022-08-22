# 
# NUMBERWALL
#
# A game for langauge learning concentrating on numbers
#
# (C) Liam Green-Hughes 2022
#
# Licence: TBD
#


extends Control

onready var correctNoise = $CorrectNoise
onready var wrongNoise = $WrongNoise

onready var timer = $Timer
onready var hintTimer = $HintTimer
onready var readAnswerTimer = $ReadAnswerTimer
onready var timerDisplay = $TimerDisplay
onready var questionDisplay = $QuestionDisplay
onready var scoreDisplay = $ScoreDisplay

onready var optBtns = [
	$VBoxContainer/HBoxContainer/Option1,
	$VBoxContainer/HBoxContainer/Option2, 
	$VBoxContainer/HBoxContainer/Option3,  
	$VBoxContainer/HBoxContainer/Option4,  
	$VBoxContainer/HBoxContainer/Option5,  
	$VBoxContainer/HBoxContainer2/Option6,  
	$VBoxContainer/HBoxContainer2/Option7,  
	$VBoxContainer/HBoxContainer2/Option8,  
	$VBoxContainer/HBoxContainer2/Option9,  
	$VBoxContainer/HBoxContainer2/Option10]

var answers = []
var correctAnswer = 0
var hintNumber = 0

export var time_before_hint_1 = 10
export var time_before_hint_2 = 7
export var score_increment = 10
export var hint_remove_1 = 5
export var hint_remove_2 = 3

const rightStyle = preload("res://correct.tres")
const wrongStyle = preload("res://wrong.tres")
const focusStyle = preload("res://focus.tres")

var translations : Resource

var kbNavEnabled : bool = false
var waitingForNewQuestion : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	translations = load("res://Words/data-%s.tres" % PlayerVariables.get_language())
	PlayerVariables.score = 0
	NewQuestion()
	timer.start()
	
func _input(event):
	if (event is InputEventKey or event is InputEventJoypadMotion or event is InputEventJoypadButton) and !kbNavEnabled:
		kbNavEnabled = true;
		optBtns[0].grab_focus()
		for i in range(0, len(optBtns)):
			optBtns[i].set("custom_styles/focus", focusStyle)
			optBtns[i].set("custom_styles/hover", StyleBoxEmpty)
				
	if (event is InputEventScreenTouch or event is InputEventMouseMotion)  and kbNavEnabled:
		kbNavEnabled = false
		for i in range(0, len(optBtns)):
			optBtns[i].set("custom_styles/focus", StyleBoxEmpty)
			optBtns[i].set("custom_styles/hover", focusStyle)
	
func NewQuestion():
	answers = []
	for i in range(0, len(optBtns)):
		var num = 0
		var unique = false
		while !unique:
			num = randi() % 100
			if num in answers:
				unique = false
			else:
				unique = true
		answers.append(num)
		optBtns[i].text = str(answers[i])  
		optBtns[i].disabled = false
		optBtns[i].set("custom_styles/hover", focusStyle)
		
	var correctAnswerKey = randi() % len(answers)-1
	correctAnswer = answers[correctAnswerKey]
	optBtns[correctAnswerKey].set("custom_styles/pressed", rightStyle)
	
	# Set pressed bg colour on right answer to green
	questionDisplay.text =  translations.get_cardinal(correctAnswer)  
	hintNumber = 0
	waitingForNewQuestion = false
	hintTimer.start(time_before_hint_1)
	
func submitAnswer(buttonNo):
	if timer.time_left == 0 or waitingForNewQuestion:
		return
	
	if answers[buttonNo] == correctAnswer:	
		if PlayerVariables.AudioEnabled:
			correctNoise.play()
		changeScore(score_increment)
		waitBeforeNewQuestion()
	elif PlayerVariables.AudioEnabled:
		wrongNoise.play()

func waitBeforeNewQuestion():
	for i in range(0, len(optBtns)):
		if answers[i] != correctAnswer:
			optBtns[i].disabled = true
	waitingForNewQuestion = true
	readAnswerTimer.start()

func _on_ReadAnswerTimer_timeout():
	readAnswerTimer.stop()
	NewQuestion()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timerDisplay.text = "%2.1f" % timer.time_left
	
	

func changeScore(amount):
	PlayerVariables.score += amount
	scoreDisplay.text = str(PlayerVariables.score)

func _on_Timer_timeout():
	timer.stop()
	hintTimer.stop()
	get_tree().change_scene("res://GameOver.tscn")

func _on_HintTimer_timeout():
	# Take 5 away on first hint, another 3 on second hint
	if hintNumber == 0:
		hideOptions(hint_remove_1)
		hintTimer.start(time_before_hint_2)
		hintNumber = 1
	elif hintNumber == 1:
		hideOptions(hint_remove_2)
		hintNumber = 2
		
func hideOptions(howMany):
	var numHidden = 0
	while numHidden != howMany:
		var i = randi() % len(optBtns)-1
		if answers[i] != correctAnswer and !optBtns[i].disabled:
			numHidden = numHidden + 1
			optBtns[i].text = ""
			optBtns[i].disabled = true
	
# TODO change to button_down, on button_up change colour back
func _on_Option1_pressed():
	submitAnswer(0)
	
func _on_Option2_pressed():
	submitAnswer(1)

func _on_Option3_pressed():
	submitAnswer(2)

func _on_Option4_pressed():
	submitAnswer(3)
	
func _on_Option5_pressed():
	submitAnswer(4)
	
func _on_Option6_pressed():
	submitAnswer(5)

func _on_Option7_pressed():
	submitAnswer(6)
	
func _on_Option8_pressed():
	submitAnswer(7)

func _on_Option9_pressed():
	submitAnswer(8)

func _on_Option10_pressed():
	submitAnswer(9)

