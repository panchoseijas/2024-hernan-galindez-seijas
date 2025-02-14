Class {
	#name : #HyperJump,
	#superclass : #Square,
	#instVars : [
		'listOfValues'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> with: aUnitsArray [

	^ self new initializeWith: aUnitsArray
]

{ #category : #'add/remove' }
HyperJump >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	| squaresToMove |
	squaresToMove := self squaresToMoveIn: aGameboard.
	squaresToMove = 0 ifTrue: [ ^ self ].
	aSpaceship move: squaresToMove negated in: aGameboard
]

{ #category : #'add/remove' }
HyperJump >> applyNormalEffectTo: aSpaceship in: aGameboard [

	| squaresToMove |
	squaresToMove := self squaresToMoveIn: aGameboard.
	squaresToMove = 0 ifTrue: [ ^ self ].
	aSpaceship move: squaresToMove in: aGameboard
]

{ #category : #'add/remove' }
HyperJump >> initializeWith: aNumberArray [

	occupiedBy := OrderedCollection new.
	listOfValues := aNumberArray asOrderedCollection.
	state := NormalState new
]

{ #category : #'add/remove' }
HyperJump >> squaresToMoveIn: aGameboard [

	| amountToMove  gameboardMeasurment |
	gameboardMeasurment := aGameboard measurementPerSquare.
	amountToMove := listOfValues removeFirst.
	listOfValues addLast: amountToMove.
	^ amountToMove // gameboardMeasurment
]
