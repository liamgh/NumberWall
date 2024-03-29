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

@onready var correctNoise = $CorrectNoise # Noise to make when answer is coreect
@onready var wrongNoise = $WrongNoise # Noise to make when answer is wrong

@onready var timer : Timer = $Timer # timer for whole game
@onready var hintTimer : Timer = $HintTimer # timer before next hint/option reduction
@onready var readAnswerTimer : Timer = $ReadAnswerTimer # time to show red/green feedback on buttton
@onready var timerDisplay = $TimerDisplay 
@onready var questionDisplay = $QuestionDisplay
@onready var scoreDisplay = $ScoreDisplay

var answers = []
var correctAnswerBtn : int  = 0 
var hintNumber : int = 0

@export var time_before_hint_1 : int = 10 # Number of seconds before first option reduction
@export var time_before_hint_2 : int = 7 # Number of seconds before second option reduction
@export var score_increment : int = 10 # Points for a correct answer
@export var hint_remove_1 : int = 5 # How many options to remove on first hint
@export var hint_remove_2 : int  = 3 # How many options to remove on second hint

var translations : Resource # File with the words in for the numbers

var waitingForNewQuestion : bool = false

signal correct_answer 
signal wrong_answer 
signal new_question
signal hide_options
signal reset_grid

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	translations = load("res://Words/data-%s.tres" % PlayerVariables.get_language())
	PlayerVariables.score = 0
	NewQuestion()
	timer.start()
	
# Generates random values for each of the buttons
# then picks one to be the right answer		
func NewQuestion():	
	answers = []
	for i in range(0, 10):
		var num = 0
		var unique = false
		while !unique:
			num = randi() % 100
			if num in answers:
				unique = false
			else:
				unique = true
		answers.append(num)
	correctAnswerBtn = randi() % len(answers)
	emit_signal("new_question", correctAnswerBtn, answers)
	var correctAnswer = answers[correctAnswerBtn]	
	questionDisplay.text =  translations.get_cardinal(correctAnswer)  
	hintNumber = 0
	waitingForNewQuestion = false
	hintTimer.set_paused(false)	
	hintTimer.start(time_before_hint_1)

# Checks if button clicked is the correct answer	
func submitAnswer(buttonNo):
	hintTimer.set_paused(true)	
	if timer.time_left == 0 or readAnswerTimer.time_left != 0:
		return
	
	if buttonNo == correctAnswerBtn:
		emit_signal("correct_answer", buttonNo)
		if PlayerVariables.AudioEnabled:
			correctNoise.play()
		changeScore(score_increment)
		waitingForNewQuestion = true
		hintTimer.stop()
		readAnswerTimer.start(1)
	else:
		emit_signal("wrong_answer", buttonNo)
		if PlayerVariables.AudioEnabled:
			wrongNoise.play()
		readAnswerTimer.start(0.5)
		

# Triggered when the timer dealy for showing red/green feedback
# on the button expires
func _on_ReadAnswerTimer_timeout():
	readAnswerTimer.stop()
	emit_signal("reset_grid")
	if waitingForNewQuestion:
		NewQuestion()
	else:
		hintTimer.set_paused(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Updates timer label with time left
func _process(_delta):
	timerDisplay.text = "%2.1f" % timer.time_left
	
# Called when the score should be adjusted	
# Also updates score displat
func changeScore(amount):
	PlayerVariables.score += amount
	scoreDisplay.text = str(PlayerVariables.score)

# Handles time out for timer for the whole game
func _on_Timer_timeout():
	timer.stop()
	hintTimer.stop()
	get_tree().change_scene_to_file("res://GameOver.tscn")

# Handles timer for hints (when some buttons go blank to reduce
# possible answers)
func _on_HintTimer_timeout():
	# Take 5 away on first hint, another 3 on second hint
	if hintNumber == 0:
		emit_signal("hide_options", hint_remove_1)
		hintTimer.start(time_before_hint_2)
		hintNumber = 1
	elif hintNumber == 1:
		emit_signal("hide_options", hint_remove_2)
		hintNumber = 2

	
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


