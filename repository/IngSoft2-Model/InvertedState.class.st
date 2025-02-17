Class {
	#name : #InvertedState,
	#superclass : #SquareSate,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
InvertedState >> applyEffectfrom: aSquare to: aSpaceship in: aGameboard [

	aSquare applyInvertedEffectTo: aSpaceship in: aGameboard
]

{ #category : #'add/remove' }
InvertedState >> invert [

	^ NormalState new.
]
