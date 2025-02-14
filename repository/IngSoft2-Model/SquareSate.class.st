Class {
	#name : #SquareSate,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
SquareSate >> applyEffectfrom: aSquare to: aSpaceship in: aGameboard [

	self subclassResponsibility
]

{ #category : #'add/remove' }
SquareSate >> invert [

	self subclassResponsibility
]
