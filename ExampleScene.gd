extends Control

var voice_files: Array = [
	"v1.ogg",
	"v2.ogg",
]

func _ready():
	for file in voice_files:
		$PanelContainer/Control/VBoxContainer/HBoxContainer3/VoiceOptionButton.add_item(file)

func _process(delta: float):
	$PanelContainer/Control/TextureRect2/TextureRect/AnimationPlayer2.play(
		"talking" if $VoiceGeneratorAudioStreamPlayer.is_reading() and not $VoiceGeneratorAudioStreamPlayer.is_waiting() else "default")

func _on_PlayButton_pressed():
	$VoiceGeneratorAudioStreamPlayer.read(
		$PanelContainer/Control/VBoxContainer/PanelContainer/HBoxContainer/PhraseLineEdit.text)


func _on_PitchHSlider_value_changed(value: float) -> void:
	$PanelContainer/Control/VBoxContainer/HBoxContainer/PitchValueLabel.text = str(value)
	$VoiceGeneratorAudioStreamPlayer.pitch_scale = value


func _on_PitchDifferenceHSlider_value_changed(value: float) -> void:
	$PanelContainer/Control/VBoxContainer/HBoxContainer2/PitchDifferenceValueLabel.text = str(value)
	$VoiceGeneratorAudioStreamPlayer.stream.random_pitch = value


func _on_VoiceOptionButton_item_selected(id: int) -> void:
	var item = $PanelContainer/Control/VBoxContainer/HBoxContainer3/VoiceOptionButton.get_item_text(id)
	$VoiceGeneratorAudioStreamPlayer.stream.audio_stream = load("res://addons/" + item)
