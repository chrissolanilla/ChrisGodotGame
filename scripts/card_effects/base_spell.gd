extends Node
class_name BaseSpell

# var level: int
# var attack: int
# var defense: int
var archetype: String
var spell_name: String
var portrait: Texture
var start_up: float
# var scene_path: String
#@onready var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
var soundEffect = preload("res://assets/sounds/EffectActivate.mp3")

#this function is meatn to be overriden if a spell contains some complicated stuff,
# at the very least they should have a archetype i think for search effects and plays or a name
func setupAttributes(metadata:CardMetaData) -> void:
	# self.level = metadata.level
	# self.attack = metadata.card_attack
	# self.defense = metadata.card_hp
	self.archetype = metadata.archetype
	self.spell_name = metadata.card_name
	self.portrait = metadata.card_portrait
	self.start_up = metadata.card_start_up
	# self.scene_path = metadata.scene_path

func activate_spell(player: CharacterBody3D, spell_card: CardMetaData, current_scene:Node, distance:float, scale:Vector3 = Vector3(1, 1, 1))-> void:
	#when we play the spell, we should spawn a sprite of the card above the player
	# Add the audio player to the scene tree
	#maybe the instance of the spell should have the audio player tbh
	#add_child(audio_player)
	#audio_player.stream = soundEffect
	#audio_player.play()
	#now we instance the sprite3d and add the texture of  the card portrait
	print("our attributes for this spell are", start_up, spell_name, archetype)
	var spell_scene = load("res://scenes/World_spell_card.tscn")
	var spell_instance = spell_scene.instantiate()
	var backside = spell_instance.get_node("backside")
	var front = spell_instance.get_node("front")
	
	front.texture = portrait
	backside.texture = portrait
	#print("spell instance texture is" , spell_instance.texture)
	#print("our portrait is ", portrait)
	#print("spell card param portrait is", spell_card.card_portrait)
	#spell_instance.texture = spell_card.card_portrait
	#now we add it to current scene
	if current_scene == null:
		print("scene is null")
		return
	current_scene.add_child(spell_instance)
	spell_instance.scale = scale
	
	#now we get AudioStreamPlayer3D in the scene and play the sound(it already has the sound inside it
	var audio_player = spell_instance.get_node("AudioStreamPlayer3D")
	# Play the sound effect
	if audio_player:
		audio_player.play()
	else:
		print("AudioStreamPlayer3D node not found")

	spell_instance.call_deferred("set_transform", Transform3D(spell_instance.transform.basis, player.get_global_transform().origin + player.get_global_transform().basis.z.normalized() * -distance))
	pass

func resolve_spell() -> void:
	#if the spell was not interupted or countered, actually play it.
	pass


# func spawn
