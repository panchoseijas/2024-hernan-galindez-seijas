Class {
	#name : #Ally,
	#superclass : #Permanent,
	#instVars : [
		'firstAlly',
		'secondAlly'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ally >> initialize [
	firstAlly := NullSpaceship new.
	secondAlly := NullSpaceship new.
]

{ #category : #operations }
Ally >> removeEffectsWith: aCardManager [

	firstAlly allyWith: NullSpaceship new.
	secondAlly allyWith: NullSpaceship new.
]

{ #category : #operations }
Ally >> use: aCardManager from: cardThrower target: aTarget [

	| otherSpaceship |
	otherSpaceship := aCardManager shipNamed: aTarget.

	aCardManager createAlliance: otherSpaceship.

	firstAlly := cardThrower.
	secondAlly := otherSpaceship.
	
	aCardManager addActiveCard: self
]
