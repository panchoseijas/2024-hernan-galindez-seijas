Class {
	#name : #MoonWalk,
	#superclass : #Square,
	#instVars : [
		'squaresToMove',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> withSquaresToMove: anAmountOfSquares [ 

	^ (self new) initializeWithSquaresToMove: anAmountOfSquares .
]

{ #category : #'add/remove' }
MoonWalk >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	aGameboard moveAll: squaresToMove except: aSpaceship
]

{ #category : #'add/remove' }
MoonWalk >> applyNormalEffectTo: aSpaceship in: aGameboard [

	aGameboard moveAll: squaresToMove negated except: aSpaceship
]

{ #category : #initialization }
MoonWalk >> initializeWithSquaresToMove: anAmountOfSquares [

	squaresToMove := anAmountOfSquares.

]
