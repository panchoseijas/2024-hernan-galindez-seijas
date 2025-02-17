Class {
	#name : #NormalState,
	#superclass : #SquareSate,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
NormalState >> applyEffectfrom: aSquare to: aSpaceship in: aGameboard [

	aSquare applyNormalEffectTo: aSpaceship in: aGameboard. 
]

{ #category : #'add/remove' }
NormalState >> invert [

	^ InvertedState new.
]
