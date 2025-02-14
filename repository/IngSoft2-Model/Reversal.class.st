Class {
	#name : #Reversal,
	#superclass : #Permanent,
	#instVars : [
		'affectedTarget'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #removing }
Reversal >> removeEffectsWith: aCardManager [

	aCardManager invertSquare: affectedTarget
]

{ #category : #operations }
Reversal >> use: aCardManager from: cardThrower target: aTarget [

	aCardManager invertSquare: aTarget.
	affectedTarget := aTarget.

	aCardManager addActiveCard: self
]
