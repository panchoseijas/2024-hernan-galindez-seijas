Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'occupiedBy',
		'gameboard',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Square class >> create [

	^ self new initialize
]

{ #category : #'as yet unclassified' }
Square >> applyEffectTo: aSpaceship in: aGameboard [

	state applyEffectfrom: self to: aSpaceship in: aGameboard
]

{ #category : #'add/remove' }
Square >> applyInvertedEffectTo: aSpaceship in: aGameboard [

	self subclassResponsibility.
]

{ #category : #'add/remove' }
Square >> applyNormalEffectTo: aSpaceship in: aGameboard [

	self subclassResponsibility 
]

{ #category : #accessing }
Square >> includes: aSpaceship [

	^ occupiedBy includes: aSpaceship
]

{ #category : #initialization }
Square >> initialize [

	occupiedBy := OrderedCollection new.
	state := NormalState new.
]

{ #category : #'add/remove' }
Square >> invert [

	state := state invert
]

{ #category : #'add/remove' }
Square >> keep: aSpaceship [

	occupiedBy add: aSpaceship.
]

{ #category : #'add/remove' }
Square >> leaves: aSpaceship [

	occupiedBy remove: aSpaceship
]
