class_name Player
extends CharacterBody2D

signal switch_spin(dir:int)

@export var animation_player: AnimationPlayer

func _ready():
	PlayerManager.player_was_hurt.connect(on_hit)

func on_hit():
	animation_player.play("Hit")
