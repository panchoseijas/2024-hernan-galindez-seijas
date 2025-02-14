Class {
	#name : #CardSquare,
	#superclass : #Square,
	#instVars : [
		'expectedNumber',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
CardSquare >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	aSpaceship discardRandomCard
]

{ #category : #'add/remove' }
CardSquare >> applyNormalEffectTo: aSpaceship in: aGameboard [

	aSpaceship giveCard: (aGameboard possibleCards) atRandom
]
