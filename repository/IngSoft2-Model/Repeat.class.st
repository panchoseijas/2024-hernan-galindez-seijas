Class {
	#name : #Repeat,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Repeat >> use: aCardManager from: cardThrower target: aTarget [

	| spaceship |
	spaceship := aCardManager shipNamed: aTarget.
	aCardManager applyLastEffectTo: spaceship
]
